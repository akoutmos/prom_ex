defmodule PromExTest do
  use ExUnit.Case, async: false

  defmodule DefaultPromExSetUp do
    use PromEx, otp_app: :prom_ex

    @impl true
    def plugins do
      [
        {PromEx.Plugins.Application, otp_app: :prom_ex},
        {PromEx.Plugins.Phoenix, router: MyAppWeb.Router}
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
      assert length(module_plugins) == 2
      assert Keyword.get(config, :otp_app) == :prom_ex
      assert Keyword.get(config, :delay_manual_start) == :no_delay
      assert Keyword.get(config, :drop_metrics_groups) == []
      assert Keyword.get(config, :upload_dashboards_on_start) == false
    end

    test "should start the correct processes under the supervision tree" do
      # Start the supervision tree for dummy PromEx Module
      DefaultPromExSetUp.start_link([])

      # Get supervsion tree child proceses
      manual_metrics_pid = Process.whereis(DefaultPromExSetUp.__manual_metrics_name__())
      metrics_collector_pid = Process.whereis(DefaultPromExSetUp.__metrics_collector_name__())
      dashboard_uploader_pid = Process.whereis(DefaultPromExSetUp.__dashboard_uploader_name__())

      assert is_pid(manual_metrics_pid)
      assert is_pid(metrics_collector_pid)
      refute is_pid(dashboard_uploader_pid)

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("prom_ex_application_primary_info")

      assert DefaultPromExSetUp
             |> PromEx.get_metrics()
             |> String.contains?("395459c")

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
end
