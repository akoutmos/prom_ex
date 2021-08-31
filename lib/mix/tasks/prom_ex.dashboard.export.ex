defmodule Mix.Tasks.PromEx.Dashboard.Export do
  @moduledoc """
  This will render a PromEx dashboard either to STDOUT or to a file depending on
  the CLI arguments that are provided.

  The following CLI flags are supported:
  ```md
  -d, --dashboard  The name of the dashboard that you would like to export from PromEx.
                   For example, if you would like to export the Ecto dashboard, provide
                   the value `ecto.json`.

  -m, --module     The PromEx module which will be used to render the dashboards.
                   This is needed to fetch any relevant assigns from the
                   `c:PromEx.dashboard_assigns/0` callback

  -s, --stdout    A boolean flag denoting that the rendered dashboard should be output
                   to STDOUT.

  -f, --file_path  If you would like the write the generated JSON dashboard definition
                   to a file, you can provide a relative file path in the project's
                   `priv` directory.

  -a, --assign     Any additional assigns you would like to pass to the dashboard for
                   rendering. You are able to pass multiple assigns by passing multiple
                   --assign arguments. For example: `--assign some=thing --assign another=thing`.
  ```
  """

  @shortdoc "Export a rendered dashboard to STDOUT or a file"

  use Mix.Task

  alias PromEx.DashboardRenderer

  @impl true
  def run(args) do
    # Compile the project
    Mix.Task.run("compile")

    # Get CLI args and set up uploader
    cli_args = parse_options(args)

    prom_ex_module =
      "Elixir.#{cli_args.module}"
      |> String.to_atom()
      |> Code.ensure_compiled()
      |> case do
        {:module, module} ->
          module

        {:error, reason} ->
          raise "#{cli_args.module} is not a valid PromEx module because #{inspect(reason)}"
      end

    check_valid_dashboard(cli_args)
    render_dashboard(prom_ex_module, cli_args)
  end

  defp parse_options(args) do
    cli_options = [module: :string, stdout: :boolean, file_path: :string, dashboard: :string, assign: [:string, :keep]]
    cli_aliases = [m: :module, s: :stdout, f: :file_path, d: :dashboard, a: :assign]

    # Parse out the arguments and put defaults where necessary
    args
    |> OptionParser.parse(aliases: cli_aliases, strict: cli_options)
    |> case do
      {options, _remaining_args, [] = _errors} ->
        options
        |> Enum.reduce(%{}, fn
          {:assign, assign_value}, acc when is_map_key(acc, :assigns) ->
            [key, value] = String.split(assign_value, "=", parts: 2)
            new_assign = {String.to_atom(key), value}
            Map.put(acc, :assigns, [new_assign | acc.assigns])

          {:assign, assign_value}, acc ->
            [key, value] = String.split(assign_value, "=", parts: 2)
            Map.put(acc, :assigns, [{String.to_atom(key), value}])

          {opt, value}, acc ->
            Map.put(acc, opt, value)
        end)
        |> Map.put_new(:assigns, [])

      {_options, _remaining_args, errors} ->
        raise "Invalid CLI args were provided: #{inspect(errors)}"
    end
    |> Map.put_new(:stdout, false)
    |> Map.put_new(:dashboard, nil)
    |> Map.put_new_lazy(:module, fn ->
      Mix.Project.config()
      |> Keyword.get(:app)
      |> Atom.to_string()
      |> Macro.camelize()
      |> Kernel.<>(".PromEx")
    end)
  end

  defp check_valid_dashboard(%{dashboard: nil}) do
    raise "You must provide a --dashboard argument"
  end

  defp check_valid_dashboard(_args) do
    :ok
  end

  defp render_dashboard(prom_ex_module, cli_args) do
    user_provided_assigns = prom_ex_module.dashboard_assigns()

    default_title =
      prom_ex_module.__otp_app__()
      |> Atom.to_string()
      |> Macro.camelize()

    default_dashboard_name =
      cli_args.dashboard
      |> Path.basename()
      |> normalize_file_name()
      |> Macro.camelize()

    default_dashboard_assigns = [
      otp_app: prom_ex_module.__otp_app__(),
      title: "#{default_title} - PromEx #{default_dashboard_name} Dashboard"
    ]

    dashboard_render =
      :prom_ex
      |> DashboardRenderer.build(cli_args.dashboard, prom_ex_module.__otp_app__())
      |> DashboardRenderer.merge_assigns(default_dashboard_assigns)
      |> DashboardRenderer.merge_assigns(user_provided_assigns)
      |> DashboardRenderer.merge_assigns(cli_args.assigns)
      |> DashboardRenderer.render_dashboard(prom_ex_module)
      |> DashboardRenderer.decode_dashboard()
      |> check_dashboard_render()

    handle_export(cli_args, prom_ex_module, dashboard_render)
  end

  defp handle_export(%{stdout: true}, _prom_ex_module, dashboard_render) do
    IO.puts(dashboard_render.rendered_file)
  end

  defp handle_export(%{file_path: file_path}, prom_ex_module, dashboard_render) do
    priv_path =
      prom_ex_module.__otp_app__()
      |> :code.priv_dir()
      |> :erlang.list_to_binary()

    full_path = Path.join([priv_path, file_path])

    File.write!(full_path, dashboard_render.rendered_file)
  end

  defp handle_export(_cli_args, _prom_ex_module, _dashboard_render) do
    raise "You must specify either a file path to write the dashboard to, or provide the --stdout flag to print to STDOUT"
  end

  defp check_dashboard_render(%DashboardRenderer{valid_json?: false}) do
    raise "The rendered dashboard yielded an invalid JSON data structure. Be sure to check your assigns."
  end

  defp check_dashboard_render(%DashboardRenderer{valid_file?: false}) do
    raise "The dashboard that you selected does not exist in PromEx. Be sure that you typed it correctly."
  end

  defp check_dashboard_render(dashboard_render) do
    dashboard_render
  end

  defp normalize_file_name(path) do
    if Path.extname(path) == "" do
      path
    else
      path
      |> Path.rootname()
      |> normalize_file_name()
    end
  end
end
