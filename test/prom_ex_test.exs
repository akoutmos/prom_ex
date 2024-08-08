defmodule PromExTest do
  use ExUnit.Case, async: false
  use Plug.Test

  defmodule ManualMetricsDelayStart do
    use PromEx, otp_app: :prom_ex

    alias PromEx.Plugins.Application

    @impl true
    def plugins do
      [{Application, otp_app: :prom_ex}]
    end

    @impl true
    def init_opts do
      PromEx.Config.build(manual_metrics_start_delay: 60_000)
    end
  end

  defmodule DisabledPromExSetUp do
    use PromEx, otp_app: :prom_ex

    alias PromEx.Plugins.{Application, Beam, Ecto, Oban, Phoenix}

    @impl true
    def plugins do
      [
        {Application, otp_app: :prom_ex},
        {Phoenix, router: TestApp.Router},
        {Beam, poll_rate: 500},
        {Ecto, otp_app: :prom_ex, repos: [Test.Repo]},
        {Oban, poll_rate: 10_000, oban_supervisors: []}
      ]
    end

    @impl true
    def dashboards do
      [{:prom_ex, "application.json"}]
    end
  end

  defmodule DefaultPromExSetUp do
    use PromEx, otp_app: :prom_ex

    alias PromEx.Plugins.{Application, Beam, Ecto, Oban, Phoenix}

    @impl true
    def plugins do
      [
        {Application, otp_app: :prom_ex},
        {Phoenix, router: TestApp.Router, endpoint: TestApp.Endpoint},
        {Beam, poll_rate: 500},
        {Ecto, otp_app: :prom_ex, repos: [Test.Repo]},
        {Oban, poll_rate: 10_000, oban_supervisors: []}
      ]
    end

    @impl true
    def dashboards do
      [{:prom_ex, "application.json"}]
    end
  end

  setup_all do
    System.put_env("GIT_SHA", "395459c")
    System.put_env("GIT_AUTHOR", "Alex")
    Application.put_env(:prom_ex, Test.Repo, telemetry_prefix: [:test, :repo])

    []
  end

  describe "DisabledPromExSetUp" do
    test "should not start the supervision tree if the disabled flag is true" do
      Application.put_env(:prom_ex, DisabledPromExSetUp, disabled: true)

      assert DisabledPromExSetUp.start_link([]) == :ignore
      assert Process.whereis(DisabledPromExSetUp) == nil
    after
      Application.put_env(:prom_ex, DisabledPromExSetUp, disabled: false)
    end
  end

  describe "DefaultPromExSetUp" do
    test "should have the correct default configs" do
      module_dashboards = DefaultPromExSetUp.dashboards()
      module_plugins = DefaultPromExSetUp.plugins()
      config = DefaultPromExSetUp.init_opts()

      assert module_dashboards == [prom_ex: "application.json"]
      assert length(module_plugins) == 5
      assert Map.get(config, :manual_metrics_start_delay) == :no_delay
      assert Map.get(config, :drop_metrics_groups) == MapSet.new([])
      assert Map.get(config, :grafana_config) == :disabled
      assert Map.get(config, :metrics_server_config) == :disabled
    end

    test "should start the correct processes under the supervision tree" do
      # Start the supervision tree for dummy PromEx Module
      DefaultPromExSetUp.start_link([])

      # Give the manual metrics manager a chance to capture application metrics
      Process.sleep(1_000)

      # Get supervsion tree child processes
      manual_metrics_pid = Process.whereis(DefaultPromExSetUp.__manual_metrics_name__())
      metrics_collector_pid = Process.whereis(DefaultPromExSetUp.__metrics_collector_name__())
      dashboard_uploader_pid = Process.whereis(DefaultPromExSetUp.__dashboard_uploader_name__())
      poller_500 = Process.whereis(:"Elixir.PromExTest.DefaultPromExSetUp.Poller.500")
      poller_5000 = Process.whereis(:"Elixir.PromExTest.DefaultPromExSetUp.Poller.5000")

      # Ensure the correct processes are running
      assert is_pid(manual_metrics_pid)
      assert is_pid(metrics_collector_pid)
      assert is_pid(poller_500)
      assert is_pid(poller_5000)
      refute is_pid(dashboard_uploader_pid)

      # Ensure period is set correctly
      poller_500_state = :sys.get_state(poller_500)
      assert poller_500_state[:period] == 500
      poller_5000_state = :sys.get_state(poller_5000)
      assert poller_5000_state[:period] == 5000

      # Validate that the running processes have the correct names
      assert DefaultPromExSetUp.__manual_metrics_name__() == DefaultPromExSetUp.ManualMetricsManager
      assert DefaultPromExSetUp.__metrics_collector_name__() == DefaultPromExSetUp.Metrics
      assert DefaultPromExSetUp.__dashboard_uploader_name__() == DefaultPromExSetUp.DashboardUploader

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("prom_ex_application_primary_info")

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("395459c")

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("Alex")

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("beam_stats_active_task_count")

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("beam_stats_port_count")

      # Ensure new metrics pop up after execution
      refute DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("phoenix_http_request_duration_milliseconds")

      refute DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("ecto_repo_init_status_info")

      conn =
        :get
        |> conn("/users")
        |> send_resp(404, "Not found")

      :telemetry.execute([:phoenix, :endpoint, :stop], %{duration: 10}, %{conn: conn})

      :telemetry.execute([:ecto, :repo, :init], %{duration: 10}, %{
        repo: Test.Repo,
        opts: [
          timeout: 10_000,
          pool_size: 10,
          database_name: "test_db",
          database_host: "postgres"
        ]
      })

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("phoenix_http_request_duration_milliseconds")

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("ecto_repo_init_status_info")

      # Kill the supervision tree
      assert DefaultPromExSetUp
             |> Process.whereis()
             |> Process.exit(:normal)
    end
  end

  describe "ErrorPromExSetUp" do
    test "should raise an error when attempting to compile an invalid PromEx module" do
      module_def = """
      defmodule ErrorPromExSetUp do
        use PromEx
      end
      """

      assert_raise RuntimeError,
                   "Failed to initialize ErrorPromExSetUp due to missing :otp_app option",
                   fn ->
                     Code.eval_string(module_def)
                   end
    end
  end

  describe "ManualMetricsDelayStart" do
    test "should not have metrics on start but can have metrics on manual refresh" do
      # Start the supervision tree for dummy PromEx Module
      ManualMetricsDelayStart.start_link([])

      # Short sleep to ensure everything is started
      Process.sleep(1_000)

      # There should be no manual metrics on start
      manual_metrics_pid = Process.whereis(ManualMetricsDelayStart.__manual_metrics_name__())
      assert is_pid(manual_metrics_pid)

      refute ManualMetricsDelayStart
             |> PromEx.get_metrics()
             |> String.contains?("prom_ex_application_primary_info")

      # Refresh the metrics and wait a second for them to populate since
      # this is a cast call
      PromEx.ManualMetricsManager.refresh_metrics(ManualMetricsDelayStart)
      Process.sleep(1_000)

      assert ManualMetricsDelayStart
             |> PromEx.get_metrics()
             |> String.contains?("prom_ex_application_primary_info")

      # Kill the supervision tree
      assert ManualMetricsDelayStart
             |> Process.whereis()
             |> Process.exit(:normal)
    end
  end

  describe "grafana_client_child_spec" do
    test ":disabled" do
      assert PromEx.grafana_client_child_spec([], :disabled, PromEx, ProcessName) == []
    end

    test "default" do
      assert PromEx.grafana_client_child_spec([], %{finch_pools: nil}, PromEx, ProcessName) == [
               {PromEx.GrafanaClient, name: ProcessName}
             ]
    end

    test "finch_pools" do
      assert PromEx.grafana_client_child_spec([], %{finch_pools: %{default: [size: 1]}}, PromEx, ProcessName) == [
               {PromEx.GrafanaClient, name: ProcessName, pools: %{default: [size: 1]}}
             ]
    end
  end
end
