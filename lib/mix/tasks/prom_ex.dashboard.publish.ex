defmodule Mix.Tasks.PromEx.Dashboard.Publish do
  @moduledoc """
  This mix task will publish dashboards to Grafana for a PromEx module. It is
  recommended that you use the functionality that is part of the PromEx supervision
  tree in order to upload dashboards as opposed to this, given that mix may not
  always be available (like in a mix release). This is more so a convenience for
  testing and validating dashboards without starting the whole application.

  The following CLI flags are supported:
  ```md
  -m, --module   The PromEx module which will be used to render the dashboards.
                 This is needed to fetch any relevant assigns from the
                 `c:PromEx.dashboard_assigns/0` callback and to get the Grafana
                 configuration from app config.

  -t, --timeout  The timeout value defines how long the mix task will wait while
                 uploading dashboards.
  ```
  """

  @shortdoc "Upload dashboards to Grafana"

  use Mix.Task

  alias Mix.Shell.IO
  alias PromEx.DashboardUploader

  @impl true
  def run(args) do
    # Compile the project
    Mix.Task.run("compile")

    # Get CLI args and set up uploader
    %{module: prom_ex_module, timeout: timeout} = parse_options(args)
    uploader_process_name = Mix.Tasks.PromEx.Publish.Uploader

    "Elixir.#{prom_ex_module}"
    |> String.to_atom()
    |> Code.ensure_compiled()
    |> case do
      {:module, module} ->
        module

      {:error, reason} ->
        raise "#{prom_ex_module} is not a valid PromEx module because #{inspect(reason)}"
    end
    |> check_grafana_configuration()
    |> upload_dashboards(uploader_process_name, timeout)
  end

  defp parse_options(args) do
    cli_options = [module: :string, timeout: :integer]
    cli_aliases = [m: :module, t: :timeout]

    # Parse out the arguments and put defaults where necessary
    args
    |> OptionParser.parse(aliases: cli_aliases, strict: cli_options)
    |> case do
      {options, _remaining_args, [] = _errors} ->
        Map.new(options)

      {_options, _remaining_args, errors} ->
        raise "Invalid CLI args were provided: #{inspect(errors)}"
    end
    |> Map.put_new(:timeout, 10_000)
    |> Map.put_new_lazy(:module, fn ->
      Mix.Project.config()
      |> Keyword.get(:app)
      |> Atom.to_string()
      |> Macro.camelize()
      |> Kernel.<>(".PromEx")
    end)
  end

  defp check_grafana_configuration(prom_ex_module) do
    if prom_ex_module.init_opts().grafana_config == :disabled do
      raise "#{prom_ex_module} has the Grafana option disabled. Please update your configuration and rerun."
    end

    prom_ex_module
  end

  defp upload_dashboards(prom_ex_module, uploader_process_name, timeout) do
    # We don't want errors in DashboardUploader to kill the mix task
    Process.flag(:trap_exit, true)

    # Start the DashboardUploader
    default_dashboard_opts = [otp_app: prom_ex_module.__otp_app__()]

    {:ok, pid} =
      DashboardUploader.start_link(
        name: uploader_process_name,
        prom_ex_module: prom_ex_module,
        default_dashboard_opts: default_dashboard_opts
      )

    receive do
      {:EXIT, ^pid, :normal} ->
        IO.info("\nPromEx dashboard upload complete! Review the above statuses for each dashboard.")

      {:EXIT, ^pid, error_reason} ->
        IO.error(
          "PromEx was unable to upload your dashboards to Grafana because:\n#{Code.format_string!(inspect(error_reason))}"
        )
    after
      timeout ->
        raise "PromEx timed out trying to upload your dashboards to Grafana"
    end
  end
end
