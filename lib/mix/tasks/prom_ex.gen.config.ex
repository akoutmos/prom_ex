defmodule Mix.Tasks.PromEx.Gen.Config do
  @moduledoc """
  This Mix Task generates a PromEx config module in your project. This config
  file acts as a starting point with instructions on how to set up PromEx
  in your application, some default PromEx metrics plugins, and their
  accompanying dashboards.

  The following CLI flags are supported:
  ```md
  -d, --datasource  The datasource that the dashboards will be reading from to populate
                    their time series data. This `datasource` value should align with
                    what is configured in Grafana from the Prometheus instance's
                    `datasource_id`.

  -o, --otp_app     The OTP application that PromEx is being installed in. This
                    should be provided as the snake case atom (minus the leading
                    colon). For example, if the `:app` value in your `mix.exs` file
                    is `:my_cool_app`, this argument should be provided as `my_cool_app`.
                    By default PromEx will read your `mix.exs` file to determine the OTP
                    application value so this is an OPTIONAL argument.
  ```
  """

  @shortdoc "Generates a PromEx configuration module"

  use Mix.Task

  alias Mix.Shell.IO

  @impl true
  def run(args) do
    # Compile the project
    Mix.Task.run("compile")

    # Get CLI args
    %{otp_app: otp_app, datasource: datasource_id} =
      args
      |> parse_options()
      |> Map.put_new_lazy(:otp_app, fn ->
        Mix.Project.config()
        |> Keyword.get(:app)
        |> Atom.to_string()
      end)
      |> case do
        %{otp_app: _otp_app, datasource: _datasource_id} = required_args ->
          required_args

        _ ->
          raise "Missing required arguments. Run mix help prom_ex.gen.config for usage instructions"
      end

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
      create_config_file(path, otp_app, datasource_id)
      IO.info("Successfully wrote out #{path}")

      first_line = "| Be sure to follow the @moduledoc instructions in #{Macro.camelize(otp_app)}.PromEx |"
      line_length = String.length(first_line) - 2
      second_line = "| to complete the PromEx setup process" <> String.duplicate(" ", line_length - 37) <> "|"
      divider = "+" <> String.duplicate("-", line_length) <> "+"

      IO.info(Enum.join(["", divider, first_line, second_line, divider], "\n"))
    else
      IO.info("Did not write file out to #{path}")
    end
  end

  defp parse_options(args) do
    cli_options = [otp_app: :string, datasource: :string]
    cli_aliases = [o: :otp_app, d: :datasource]

    args
    |> OptionParser.parse(aliases: cli_aliases, strict: cli_options)
    |> case do
      {options, _remaining_args, [] = _errors} ->
        Map.new(options)

      {_options, _remaining_args, errors} ->
        raise "Invalid CLI args were provided: #{inspect(errors)}"
    end
  end

  defp create_config_file(path, otp_app, datasource_id) do
    module_name = Macro.camelize(otp_app)

    assigns = [
      datasource_id: datasource_id,
      module_name: module_name,
      otp_app: otp_app
    ]

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

      1. Update your configuration (config.exs, dev.exs, prod.exs, releases.exs, etc) to
         configure the necessary bit of PromEx. Be sure to check out `PromEx.Config` for
         more details regarding configuring PromEx:
         ```
         config :<%= @otp_app %>, <%= @module_name %>.PromEx,
           disabled: false,
           manual_metrics_start_delay: :no_delay,
           drop_metrics_groups: [],
           grafana: :disabled,
           metrics_server: :disabled
         ```

      2. Add this module to your application supervision tree. It should be one of the first
         things that is started so that no Telemetry events are missed. For example, if PromEx
         is started after your Repo module, you will miss Ecto's init events and the dashboards
         will be missing some data points:
         ```
         def start(_type, _args) do
           children = [
             <%= @module_name %>.PromEx,

             ...
           ]

           ...
         end
         ```

      3. Update your `endpoint.ex` file to expose your metrics (or configure a standalone
         server using the `:metrics_server` config options). Be sure to put this plug before
         your `Plug.Telemetry` entry so that you can avoid having calls to your `/metrics`
         endpoint create their own metrics and logs which can pollute your logs/metrics given
         that Prometheus will scrape at a regular interval and that can get noisy:
         ```
         defmodule <%= @module_name %>Web.Endpoint do
           use Phoenix.Endpoint, otp_app: :<%= @otp_app %>

           ...

           plug PromEx.Plug, prom_ex_module: <%= @module_name %>.PromEx

           ...
         end
         ```

      4. Update the list of plugins in the `plugins/0` function return list to reflect your
         application's dependencies. Also update the list of dashboards that are to be uploaded
         to Grafana in the `dashboards/0` function.
      \"\"\"

      use PromEx, otp_app: :<%= @otp_app %>

      alias PromEx.Plugins

      @impl true
      def plugins do
        [
          # PromEx built in plugins
          Plugins.Application,
          Plugins.Beam
          # {Plugins.Phoenix, router: <%= @module_name %>Web.Router, endpoint: <%= @module_name %>Web.Endpoint},
          # Plugins.Ecto,
          # Plugins.Oban,
          # Plugins.PhoenixLiveView,
          # Plugins.Absinthe,
          # Plugins.Broadway,

          # Add your own PromEx metrics plugins
          # <%= @module_name %>.Users.PromExPlugin
        ]
      end

      @impl true
      def dashboard_assigns do
        [
          datasource_id: "<%= @datasource_id %>",
          default_selected_interval: "30s"
        ]
      end

      @impl true
      def dashboards do
        [
          # PromEx built in Grafana dashboards
          {:prom_ex, "application.json"},
          {:prom_ex, "beam.json"}
          # {:prom_ex, "phoenix.json"},
          # {:prom_ex, "ecto.json"},
          # {:prom_ex, "oban.json"},
          # {:prom_ex, "phoenix_live_view.json"},
          # {:prom_ex, "absinthe.json"},
          # {:prom_ex, "broadway.json"},

          # Add your dashboard definitions here with the format: {:otp_app, "path_in_priv"}
          # {:<%= @otp_app %>, "/grafana_dashboards/user_metrics.json"}
        ]
      end
    end
    """
  end
end
