defmodule Mix.Tasks.PromEx.Publish do
  @moduledoc """
  This will publish dashboards to grafana for a PromEx module.
  """

  use Mix.Task

  alias Mix.Shell.IO
  alias PromEx.{GrafanaClient, GrafanaClient.Connection}

  @impl true
  def run(args) do
    # Compile the project
    Mix.Task.run("compile")

    prom_ex_module =
      args
      |> parse_options()
      |> Map.get_lazy(:module, fn ->
        Mix.Project.config()
        |> Keyword.get(:app)
        |> Atom.to_string()
        |> Macro.camelize()
        |> Kernel.<>(".PromEx")
      end)

    "Elixir.#{prom_ex_module}"
    |> String.to_atom()
    |> Code.ensure_compiled()
    |> case do
      {:module, module} ->
        module

      {:error, reason} ->
        raise "#{prom_ex_module} is not a valid PromEx module because #{inspect(reason)}"
    end
    |> upload_dashboards()
  end

  defp parse_options(args) do
    cli_options = [module: :string]
    cli_aliases = [m: :module]

    args
    |> OptionParser.parse(aliases: cli_aliases, strict: cli_options)
    |> case do
      {options, _remaining_args, [] = _errors} ->
        Map.new(options)

      {_options, _remaining_args, errors} ->
        raise "Invalid CLI args were provided: #{inspect(errors)}"
    end
  end

  defp upload_dashboards(prom_ex_module) do
    otp_app = Keyword.fetch!(prom_ex_module.init_opts(), :otp_app)
    dashboards = prom_ex_module.dashboards()

    %{
      grafana_host: grafana_host,
      grafana_auth_token: grafana_auth_token,
      grafana_datasource_id: _grafana_datasource_id
    } =
      otp_app
      |> Application.get_env(prom_ex_module)
      |> Map.new()

    finch_name = Module.concat([prom_ex_module, Finch])
    Finch.start_link(name: finch_name)
    grafana_conn = Connection.build(finch_name, grafana_host, grafana_auth_token)

    # Iterate over all the configured dashboards and upload them
    dashboards
    |> Enum.each(fn
      full_path when is_binary(full_path) ->
        upload_dashboard(full_path, grafana_conn)

      {app, dashboard_path} ->
        priv_path =
          app
          |> :code.priv_dir()
          |> :erlang.list_to_binary()

        priv_path
        |> Path.join(dashboard_path)
        |> upload_dashboard(grafana_conn)
    end)

    # No longer need this short-lived Finch process
    finch_name
    |> Process.whereis()
    |> Process.exit(:normal)
  end

  defp upload_dashboard(full_dashboard_path, grafana_conn) do
    case GrafanaClient.upload_dashboard(grafana_conn, full_dashboard_path) do
      {:ok, _response_payload} ->
        IO.info("Successfully uploaded #{full_dashboard_path} to Grafana.")

      {:error, %Mint.TransportError{reason: :nxdomain}} ->
        IO.error(
          "Failed to upload #{full_dashboard_path} to Grafana because #{grafana_conn.base_url} cannot be reached"
        )

      {:error, reason} ->
        IO.error("Failed to upload #{full_dashboard_path} to Grafana: #{inspect(reason)}")
    end
  end
end
