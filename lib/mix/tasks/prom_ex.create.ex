defmodule Mix.Tasks.PromEx.Create do
  @moduledoc """
  This will generate a PromEx config module in the appropriate place
  """

  use Mix.Task

  alias Mix.Shell.IO

  @impl true
  def run(args) do
    # Compile the project
    Mix.Task.run("compile")

    # Get CLI args
    otp_app =
      args
      |> parse_options()
      |> Map.get_lazy(:otp_app, fn ->
        Mix.Project.config()
        |> Keyword.get(:app)
        |> Atom.to_string()
      end)

    # Generate relevant path info
    project_root = File.cwd!()
    path = Path.join([project_root, "lib", otp_app, "prom_ex.ex"])
    dirname = Path.dirname(path)

    unless File.exists?(dirname) do
      raise "Required directory path #{dirname} does not exist. " <>
              "Be sure that the --otp-app argument or that you Mix project file is correct."
    end

    write_file =
      if File.exists?(path) do
        IO.yes?("File already exists at #{path}. Overwrite?")
      else
        true
      end

    if write_file do
      # Write out the config file
      create_config_file(path, otp_app)
      IO.info("Successfully wrote out #{path}")

      IO.info(
        "Be sure to follow the @moduledoc instructions in the generated module to complete the PromEx setup process."
      )
    else
      IO.info("Did not write file out to #{path}")
    end
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
  end

  defp create_config_file(path, otp_app) do
    module_name = Macro.camelize(otp_app)
    assigns = [module_name: module_name, otp_app: otp_app]

    module_template =
      prom_ex_module_template()
      |> EEx.eval_string(assigns: assigns)

    path
    |> File.write!(module_template)
  end

  defp prom_ex_module_template do
    """
    defmodule <%= @module_name %>.PromEx do
      @moduledoc \"\"\"
      Be sure to add the following to finish setting up PromEx:

      1. Update your configuration (config.exs, dev.exs, prod.exs, releases.exs, etc):
      ```
        config :<%= @otp_app %>, <%= @module_name %>.PromEx,
          grafana_host: "<YOUR GRAFANA HOST HERE>",
          grafana_auth_token: "<YOUR GRAFANA AUTH TOKEN HERE>",
          grafana_datasource_id: "<THE NAME OF YOUR PROMETHEUS DATA SOURCE HERE>"
      ```

      2. Add this module to your application supervision tree:
      ```
      def start(_type, _args) do
        children = [
          ...

          <%= @module_name %>.PromEx
        ]

        ...
      end
      ```

      3. Update your `endpoint.ex` file to expose your metrics:
      ```
      defmodule <%= @module_name %>Web.Endpoint do
        use Phoenix.Endpoint, otp_app: :<%= @otp_app %>

        ...

        plug PromEx.Plug, prom_ex_module: <%= @module_name %>.PromEx

        ...
      end
      ```
      \"\"\"

      use PromEx,
        otp_app: :<%= @otp_app %>,
        delay_manual_start: :no_delay,
        drop_metrics_groups: [],
        upload_dashboards_on_start: true

      @impl true
      def plugins do
        [
          # PromEx built in plugins
          {PromEx.Plugins.Application, otp_app: :<%= @otp_app %>},
          PromEx.Plugins.Beam,
          {PromEx.Plugins.Phoenix, router: <%= @module_name %>Web.Router}

          # Add your own PromEx metrics plugins
          # <%= @module_name %>.Users.PromEx
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
          # {:<%= @otp_app %>, "/grafana_dashboards/user_metrics.json"}
        ]
      end
    end
    """
  end
end
