defmodule Mix.Tasks.PromEx.Publish do
  @moduledoc """
  This will publish dashboards to grafana
  """

  use Mix.Task

  alias Mix.Project
  alias Mix.Shell.IO
  alias PromEx.{GrafanaClient, GrafanaClient.Connection}

  @impl true
  def run(args) do
    # Get PromEx config file
    prom_ex_config = get_prom_ex_config()

    # Fetch CLI args
    %{host: host, auth_token: auth_token} =
      args
      |> parse_options()
      |> check_args()

    # Start Finch process and build Grafana connection
    :ok = Application.ensure_started(:telemetry)
    finch_name = PromEx.Finch
    Finch.start_link(name: finch_name)
    grafana_conn = Connection.build(finch_name, host, auth_token)

    # Iterate over all the configured dashboards and upload them
    prom_ex_config
    |> Map.fetch!(:dashboards)
    |> Enum.each(fn {app, dashboard_path} ->
      priv_path =
        app
        |> :code.priv_dir()
        |> :erlang.list_to_binary()

      full_dashboard_path = Path.join(priv_path, dashboard_path)

      case GrafanaClient.upload_dashboard(grafana_conn, full_dashboard_path) do
        {:ok, _response_payload} ->
          IO.info("OK - Uploaded #{Path.basename(full_dashboard_path)}")

        {:error, _reason} ->
          IO.error("ERROR - Failed to upload #{Path.basename(full_dashboard_path)}")
      end
    end)
  end

  defp parse_options(args) do
    cli_options = [host: :string, auth_token: :string]
    cli_aliases = [h: :host, a: :auth_token]

    args
    |> OptionParser.parse(aliases: cli_aliases, strict: cli_options)
    |> case do
      {options, _remaining_args, [] = _errors} ->
        options
        |> Enum.map(fn {key, value} -> {key, normalize_value(value)} end)
        |> Map.new()

      {_options, _remaining_args, errors} ->
        raise "Invalid CLI args were provided: #{inspect(errors)}"
    end
  end

  defp get_prom_ex_config do
    app_priv_dir =
      Project.config()
      |> Keyword.get(:app)
      |> :code.priv_dir()
      |> :erlang.list_to_binary()

    prom_ex_config = Path.join([app_priv_dir, "grafana_dashboards", ".prom_ex.exs"])

    if not File.exists?(prom_ex_config) do
      raise "PromEx configuration file does not exist in the application priv dir. You can create this file by running: mix prom_ex.gen.config"
    end

    {config, _bindings} =
      prom_ex_config
      |> File.read!()
      |> Code.eval_string()

    config
  end

  defp check_args(%{host: _, auth_token: _} = args), do: args
  defp check_args(%{host: _}), do: raise("Missing required CLI argument --auth-token")
  defp check_args(%{auth_token: _}), do: raise("Missing required CLI argument --host")
  defp check_args(_), do: raise("Missing required CLI arguments")

  defp normalize_value("$" <> env_var), do: System.fetch_env!(env_var)
  defp normalize_value(value), do: value
end
