defmodule PromEx.Plugins.Application do
  @moduledoc """
  This plugin captures metrics regarding your application, its dependencies, and
  associated with the aforementioned items.
  """

  use PromEx

  @impl true
  def manual_metrics(opts) do
    otp_app = Keyword.fetch!(opts, :otp_app)
    apps = Keyword.get(opts, :deps, :all)

    Manual.build(
      :default,
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
