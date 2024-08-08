defmodule Mix.Tasks.PromEx.Gen.ConfigTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureIO
  import Mix.Tasks.PromEx.Gen.Config

  @moduletag :mix_task
  @moduletag :mix_task_gen_config

  setup do
    tmp_dir = Path.join(File.cwd!(), "tmp")

    sample_app_dir = Path.join([tmp_dir, "lib", "sample"])
    File.mkdir_p!(sample_app_dir)

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

    :ok
  end

  test "raises if invalid args are present" do
    assert_raise RuntimeError, ~r/Invalid CLI args/, fn ->
      run(~w(--unexpected unknown))
    end
  end

  test "raises if datasource arg is missing" do
    assert_raise RuntimeError, ~r/Missing required arguments/, fn ->
      run([])
    end
  end

  test "raises if otp_app directory does not exist" do
    assert_raise RuntimeError, ~r/Required directory path/, fn ->
      run(~w(-d an_id -o whoa_there))
    end
  end

  test "otp_app can be provided as an arg", ctx do
    capture_io(fn ->
      File.cd!(ctx.tmp_dir, fn -> run(~w(-d an_id -o sample)) end)
    end)

    contents =
      ctx.sample_app_dir
      |> Path.join("prom_ex.ex")
      |> File.read!()

    # Datasource ID
    assert contents =~ ~r/datasource_id: "an_id"/
    # Module name
    assert contents =~ ~r/defmodule Sample.PromEx/
    # OTP app
    assert contents =~ ~r/use PromEx, otp_app: :sample/
  end

  test "module can be provided as an arg", ctx do
    capture_io(fn ->
      File.cd!(ctx.tmp_dir, fn -> run(~w(-d an_id -o sample -m AnotherPromEx)) end)
    end)

    contents =
      ctx.sample_app_dir
      |> Path.join("another_prom_ex.ex")
      |> File.read!()

    # Module name
    assert contents =~ ~r/defmodule Sample.AnotherPromEx/
  end

  test "prompts user for confirmation if config is already generated", ctx do
    # File did not exist previously
    assert capture_io(fn ->
             File.cd!(ctx.tmp_dir, fn -> run(~w(-d an_id -o sample)) end)
           end) =~ "Success"

    assert capture_io([input: "n"], fn ->
             File.cd!(ctx.tmp_dir, fn -> run(~w(-d an_id -o sample)) end)
           end) =~ "Did not write file out"

    assert capture_io([input: "y"], fn ->
             File.cd!(ctx.tmp_dir, fn -> run(~w(-d an_id -o sample)) end)
           end) =~ "Success"
  end

  test "otp_app is read from config if missing", ctx do
    capture_io(fn ->
      Mix.Project.in_project(:sample, ctx.tmp_dir, fn _ ->
        run(~w(-d an_id))
      end)
    end)

    contents =
      ctx.sample_app_dir
      |> Path.join("prom_ex.ex")
      |> File.read!()

    # Datasource ID
    assert contents =~ ~r/datasource_id: "an_id"/
    # Module name
    assert contents =~ ~r/defmodule Sample.PromEx/
    # OTP app
    assert contents =~ ~r/use PromEx, otp_app: :sample/
  end
end
