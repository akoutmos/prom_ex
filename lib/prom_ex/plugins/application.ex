defmodule PromEx.Plugins.Application do
  @moduledoc """
  This plugin captures metrics regarding your application, and its dependencies. Specifically,
  it captures the versions of your application and the application dependencies and also
  how many modules each depepndency is bringing into the project.

  This plugin supports the following options:
  - `otp_app`: This is a REQUIRED option and is the name of you application in snake case (E.g. :my_cool_app).

  - `deps`: This option is OPTIONAL and defines what dependencies the plugin should track. A value of `:all`
    means that PromEx will fetch details on all application dependencies. A list of dependency names like
    `[:phoenix, :ecto, :unplug]` means that PromEx will only fetch details regarding those dependencies.

  This plugin exposes the following metric groups:
  - `:application_versions_manual_metrics`

  To use plugin in your application, add the following to your application supervision tree:
  ```
  def start(_type, _args) do
    children = [
      ...
      {
        PromEx,
        plugins: [
          {PromEx.Plugins.Application, [otp_app: :my_cool_app]},
          ...
        ],
        delay_manual_start: :no_delay
      }
    ]

    opts = [strategy: :one_for_one, name: WebApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
  ```

  This plugin exposes manual metrics so be sure to configure the PromEx `:delay_manual_start` as required.
  """

  use PromEx

  @impl true
  def manual_metrics(opts) do
    otp_app = Keyword.fetch!(opts, :otp_app)
    apps = Keyword.get(opts, :deps, :all)

    Manual.build(
      :application_versions_manual_metrics,
      {__MODULE__, :apps_running, [otp_app, apps]},
      [
        # Capture information regarding the primary application (i.e the user's application)
        last_value(
          [otp_app | [:application, :primary, :info]],
          event_name: [otp_app | [:application, :primary, :info]],
          description: "Information regarding the primary application.",
          measurement: :status,
          tags: [:name, :version, :modules]
        ),

        # Capture information regarding the application dependencies (i.e the user's libs)
        last_value(
          [otp_app | [:application, :dependency, :info]],
          event_name: [otp_app | [:application, :dependency, :info]],
          description: "Information regarding the application's dependencies.",
          measurement: :status,
          tags: [:name, :version, :modules]
        )
      ]
    )
  end

  @doc false
  def apps_running(otp_app, apps) do
    started_apps =
      Application.started_applications()
      |> Enum.map(fn {app, _description, version} ->
        {app, :erlang.iolist_to_binary(version)}
      end)
      |> Map.new()

    started_apps = if apps == :all, do: started_apps, else: Map.take(started_apps, apps)

    loaded_only_apps =
      Application.loaded_applications()
      |> Enum.map(fn {app, _description, version} ->
        {app, :erlang.iolist_to_binary(version)}
      end)
      |> Map.new()
      |> Map.drop(Map.keys(started_apps))

    loaded_only_apps = if apps == :all, do: loaded_only_apps, else: Map.take(loaded_only_apps, apps)

    # Emit primary app details
    :telemetry.execute(
      [otp_app | [:application, :primary, :info]],
      %{
        status: if(Map.has_key?(started_apps, otp_app), do: 1, else: 0)
      },
      %{
        name: otp_app,
        version:
          Map.get_lazy(started_apps, otp_app, fn ->
            Map.get(loaded_only_apps, otp_app, "undefined")
          end),
        modules: length(Application.spec(otp_app)[:modules])
      }
    )

    started_apps = Map.delete(started_apps, otp_app)
    loaded_only_apps = Map.delete(loaded_only_apps, otp_app)

    # Loop through other desired apps and fetch details
    started_apps
    |> Enum.each(fn {app, version} ->
      :telemetry.execute(
        [otp_app | [:application, :dependency, :info]],
        %{status: 1},
        %{name: app, version: version, modules: length(Application.spec(app)[:modules])}
      )
    end)

    loaded_only_apps
    |> Enum.each(fn {app, version} ->
      :telemetry.execute(
        [otp_app | [:application, :dependency, :info]],
        %{status: 0},
        %{name: app, version: version, modules: length(Application.spec(app)[:modules])}
      )
    end)
  end
end
