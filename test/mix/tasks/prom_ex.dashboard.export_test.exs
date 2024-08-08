defmodule Mix.Tasks.PromEx.Dashboard.ExportTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureIO

  require IEx

  alias Mix.Tasks.PromEx.Dashboard.Export
  alias Mix.Tasks.PromEx.Gen.Config

  @moduletag :mix_task
  @moduletag :mix_task_dashboard_export

  setup do
    tmp_dir = Path.join(File.cwd!(), "tmp")

    sample_app_dir = Path.join([tmp_dir, "lib", "sample"])
    File.mkdir_p!(sample_app_dir)

    sample_app_priv_dir = Path.join([tmp_dir, "priv"])
    File.mkdir_p!(sample_app_priv_dir)

    Code.compiler_options(ignore_module_conflict: true)
    on_exit(fn -> File.rm_rf!(tmp_dir) end)

    [sample_app_dir: sample_app_dir, tmp_dir: tmp_dir]
  end

  setup ctx do
    path = Path.join(ctx.tmp_dir, "mix.exs")

    contents = """
    defmodule Sample.MixProject do
      use Mix.Project

      def project do
        [
          app: :sample,
          version: "0.1.0"
        ]
      end
    end
    """

    File.write!(path, contents)

    Code.ensure_compiled(Sample.MixProject)
    Code.ensure_loaded(Sample.MixProject)
    Code.ensure_loaded(Mix.Tasks.PromEx.Dashboard.Export)

    :ok
  end

  test "raises if invalid args are present" do
    assert_raise RuntimeError, ~r/Invalid CLI args/, fn ->
      Export.run(~w(--unexpected unknown))
    end
  end

  test "raises if invalid PromEx module is provided" do
    assert_raise RuntimeError, ~r/is not a valid PromEx module/, fn ->
      Export.run([])
    end
  end

  test "raises if the dashboard does not exist", ctx do
    assert_raise RuntimeError, ~r/The dashboard that you selected does not exist/, fn ->
      capture_io(fn ->
        File.cd!(ctx.tmp_dir, fn ->
          Config.run(~w(-d an_id -o sample))
          Code.compile_file("lib/sample/prom_ex.ex")
          Export.run(~w(-m Sample.PromEx -d invalid_dashboard.json))
        end)
      end)
    end
  end

  test "raises if the dashboard arg is not present", ctx do
    assert_raise RuntimeError, ~r/You must provide a --dashboard argument/, fn ->
      capture_io(fn ->
        File.cd!(ctx.tmp_dir, fn ->
          Config.run(~w(-d an_id -o sample))
          Code.compile_file("lib/sample/prom_ex.ex")
          Export.run(~w(-m Sample.PromEx))
        end)
      end)
    end
  end

  test "raises if the user does not specify output destination", ctx do
    assert_raise RuntimeError, ~r/You must specify either a file path to write the dashboard to/, fn ->
      capture_io(fn ->
        File.cd!(ctx.tmp_dir, fn ->
          Config.run(~w(-d an_id -o sample))
          Code.compile_file("lib/sample/prom_ex.ex")
          Export.run(~w(-m Sample.PromEx -d phoenix.json))
        end)
      end)
    end
  end

  test "outputs to STDOUT if the -s flag is present", ctx do
    output =
      capture_io(fn ->
        File.cd!(ctx.tmp_dir, fn ->
          Config.run(~w(-d an_id -o sample))
          Code.compile_file("lib/sample/prom_ex.ex")
          Export.run(~w(-m Sample.PromEx -d phoenix.json -s))
        end)
      end)

    assert output =~ ~s("datasource": "an_id")
  end

  test "outputs to STDOUT if the --stdout flag is present", ctx do
    output =
      capture_io(fn ->
        File.cd!(ctx.tmp_dir, fn ->
          Config.run(~w(-d an_id -o sample))
          Code.compile_file("lib/sample/prom_ex.ex")
          Export.run(~w(-m Sample.PromEx -d phoenix.json --stdout))
        end)
      end)

    assert output =~ ~s("datasource": "an_id")
  end

  test "outputs to STDOUT if the -s flag is present and there is an assign override", ctx do
    output =
      capture_io(fn ->
        File.cd!(ctx.tmp_dir, fn ->
          Config.run(~w(-d an_id -o sample))
          Code.compile_file("lib/sample/prom_ex.ex")
          Export.run(~w(-m Sample.PromEx -d phoenix.json -s -a datasource_id=another_id))
        end)
      end)

    assert output =~ ~s("datasource": "another_id")
  end

  test "should raise if an invalid JSON document is produced", ctx do
    assert_raise RuntimeError, ~r/The rendered dashboard yielded an invalid JSON data structure./, fn ->
      capture_io(fn ->
        File.cd!(ctx.tmp_dir, fn ->
          Config.run(~w(-d an_id -o sample))
          Code.compile_file("lib/sample/prom_ex.ex")
          Export.run(~w(-m Sample.PromEx -d phoenix.json -s -a datasource_id=\"another_id))
        end)
      end)
    end
  end

  test "outputs to STDOUT if the -s flag is present and there are multiple assign overrides", ctx do
    output =
      capture_io(fn ->
        File.cd!(ctx.tmp_dir, fn ->
          Config.run(~w(-d an_id -o sample))
          Code.compile_file("lib/sample/prom_ex.ex")

          Export.run(
            ~w(-m Sample.PromEx -d phoenix.json -s -a datasource_id=another_id -a prom_ex_metric_prefix=another_app_prom_ex_prom_ex)
          )
        end)
      end)

    assert output =~ ~s("datasource": "another_id")
    assert output =~ ~s(label_values(another_app_prom_ex_prom_ex_status_info, instance)
  end
end
