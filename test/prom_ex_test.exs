defmodule PromExTest do
  use ExUnit.Case, async: false

  defmodule ManualMetricsDelayStart do
    use PromEx,
      otp_app: :prom_ex,
      delay_manual_start: 60_000

    alias PromEx.Plugins.Application

    @impl true
    def plugins do
      [{Application, otp_app: :prom_ex}]
    end
  end

  defmodule DefaultPromExSetUp do
    use PromEx, otp_app: :prom_ex

    alias PromEx.Plugins.{Application, Beam, Phoenix}

    @impl true
    def plugins do
      [
        {Application, otp_app: :prom_ex},
        {Phoenix, router: MyAppWeb.Router},
        {Beam, poll_rate: 500}
      ]
    end

    @impl true
    def dashboards do
      [{:prom_ex, "application.json"}]
    end
  end

  setup_all do
    System.put_env("APPLICATION_GIT_SHA", "395459c")

    []
  end

  describe "DefaultPromExSetUp" do
    test "should have the correct default configs" do
      module_dashboards = DefaultPromExSetUp.dashboards()
      module_plugins = DefaultPromExSetUp.plugins()
      config = DefaultPromExSetUp.init_opts()

      assert module_dashboards == [prom_ex: "application.json"]
      assert length(module_plugins) == 3
      assert Keyword.get(config, :otp_app) == :prom_ex
      assert Keyword.get(config, :delay_manual_start) == :no_delay
      assert Keyword.get(config, :drop_metrics_groups) == []
      assert Keyword.get(config, :upload_dashboards_on_start) == false
    end

    test "should start the correct processes under the supervision tree" do
      # Start the supervision tree for dummy PromEx Module
      DefaultPromExSetUp.start_link([])

      # Give the manual metrics manager a chance to capture application metrics
      Process.sleep(1_000)

      # Get supervsion tree child proceses
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
             |> String.contains?("beam_stats_active_task_count")

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("beam_stats_port_count")

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
end
