defmodule PromEx.Plugins.ObanTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Polling
  alias PromEx.Plugins.Oban, as: ObanPlugin
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [{PromEx.Plugins.Oban, oban_supervisors: [Oban]}]
    end
  end

  defmodule TestRepo do
    def child_spec(_opts) do
      %{
        id: __MODULE__,
        start: {__MODULE__, :start_link, []},
        type: :supervisor
      }
    end

    def start_link do
      Agent.start_link(fn -> :ok end, name: __MODULE__)
    end

    def all(_query), do: []
    def all(_query, _opts), do: []
    def get_dynamic_repo, do: nil

    # Required by Oban - provides repository configuration
    def config do
      [
        otp_app: :prom_ex,
        adapter: Ecto.Adapters.Postgres,
        database: "test_db",
        hostname: "localhost"
      ]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)

    Events.execute_all(:oban)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :oban)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert [_, _, _, _] = ObanPlugin.event_metrics(otp_app: :prom_ex)
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert %Polling{} = ObanPlugin.polling_metrics(otp_app: :prom_ex)
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert [] == ObanPlugin.manual_metrics([])
    end
  end

  describe "Integration test - named supervisor" do
    test "execute_queue_metrics uses config of named supervisor if Oban instance is not running" do
      start_supervised!(TestRepo)

      oban_config = [
        # Named supervisor - this is key!
        name: CustomApp.Jobs.Oban,
        repo: TestRepo,
        queues: [default: 10, high: 5],
        plugins: [],
        # Prevent automatic job processing
        testing: :manual,
        # Use a minimal notifier for testing
        notifier: {Oban.Notifiers.PG, []},
        # Use isolated peer for testing
        peer: {Oban.Peers.Isolated, [leader?: false]}
      ]

      {:ok, _oban_pid} = start_supervised({Oban, oban_config})
      :timer.sleep(200)

      # Verify our named supervisor is running
      named_supervisor_pid = Oban.Registry.whereis(CustomApp.Jobs.Oban)
      assert is_pid(named_supervisor_pid), "CustomApp.Jobs.Oban supervisor should be running"

      # Verify we can get its config
      config = Oban.Registry.config(CustomApp.Jobs.Oban)
      assert config.name == CustomApp.Jobs.Oban

      # Verify there's no default "Oban" instance
      default_supervisor_pid = Oban.Registry.whereis(Oban)
      assert is_nil(default_supervisor_pid), "Default Oban instance should NOT exist"

      named_supervisors = MapSet.new([CustomApp.Jobs.Oban])

      refute_error(fn ->
        ObanPlugin.execute_queue_metrics(named_supervisors)
      end)
    end
  end

  defp refute_error(fun) do
    try do
      fun.()
      :ok
    rescue
      error -> flunk("Expected no error, but got: #{inspect(error)}")
    end
  end
end
