defmodule Mix.Tasks.PromEx.Create do
  @moduledoc """
  This will generate a PromEx config module
  """

  use Mix.Task

  @impl true
  def run(args) do
    # Compile the project
    Mix.Task.run("compile")

    # Get CLI args
    %{otp_app: otp_app} = parse_options(args)

    # Generate relevant path info
    project_root = File.cwd!()
    path = Path.join([project_root, "lib", "#{otp_app}.exx"])

    # Write out the config file
    create_config_file(path, otp_app)
  end

  defp parse_options(args) do
    cli_options = [otp_app: :string]
    cli_aliases = [o: :otp_app]

    args
    |> OptionParser.parse(aliases: cli_aliases, strict: cli_options)
    |> case do
      {options, _remaining_args, [] = _errors} ->
        Map.new(options)

      {_options, _remaining_args, errors} ->
        raise "Invalid CLI args were provided: #{inspect(errors)}"
    end
    |> case do
      %{otp_app: _} = parsed_options ->
        parsed_options

      _ ->
        raise "Missing required arguments. Run mix help prom_ex.create for more information"
    end
  end

  defp create_config_file(path, otp_app) do
    root_module_name = Macro.camelize(otp_app)

    path
    |> File.write!("""
    defmodule #{inspect(root_module_name)}.PromEx do
      @moduledoc \"\"\"
      Be sure to add the following to finish setting up PromEx:

      1. Update your configuration (config.exs, dev.exs, prod.exs, releases.exs, etc):
      ```
        config #{inspect(otp_app)}, #{inspect(root_module_name)}.PromEx,
          grafana_host: "<YOUR GRAFANA HOST HERE>",
          grafana_auth_token: "<YOUR GRAFANA AUTH TOKEN HERE>",
          grafana_datasource_id: "<THE NAME OF YOUR PROMETHEUS DATA SOURCE HERE>"
      ```

      2. Add this module to your application supervision tree:
      ```
      def start(_type, _args) do
        children = [
          ...

          WebApp.PromEx
        ]

        ...
      end
      ```

      3. Update your `endpoint.ex` file to expose your metrics:
      ```
      defmodule #{inspect(root_module_name)}Web.Endpoint do
        use Phoenix.Endpoint, otp_app: #{inspect(otp_app)}

        ...

        plug PromEx.Plug, prom_ex_module: #{inspect(root_module_name)}.PromEx

        ...
      end
      ```
      \"\"\"

      use PromEx,
        otp_app: #{inspect(otp_app)},
        delay_manual_start: :no_delay,
        drop_metrics_groups: [],
        upload_dashboards_on_start: true

      @impl true
      def plugins do
        [
          # PromEx built in plugins
          {PromEx.Plugins.Application, otp_app: #{inspect(otp_app)}},
          PromEx.Plugins.Beam,
          {PromEx.Plugins.Phoenix, router: #{root_module_name}Web.Router}

          # Add your own PromEx metrics plugins
          # #{inspect(root_module_name)}.Users.PromEx
        ]
      end

      @impl true
      def dashboards do
        [
          # PromEx built in dashboard definitions. Remove dashboards that you do not need
          {:prom_ex, "application.json"},
          {:prom_ex, "beam.json"},
          {:prom_ex, "phoenix.json"}

          # Add your dashboard definitions here with the format: {:otp_app, "path_in_priv"}
          # {#{inspect(otp_app)}, "/grafana_dashboards/user_metrics.json"}
        ]
      end
    end
    """)
  end
end
