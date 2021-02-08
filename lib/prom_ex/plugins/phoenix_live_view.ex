if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule PromEx.Plugins.PhoenixLiveView do
    @moduledoc """
    This plugin captures metrics emitted by PhoenixLiveView. Specifically, it captures events related to the
    mount, handle_event, and handle_params callbacks for live views and live components.

    This plugin supports the following options:


    This plugin exposes the following metric groups:
    - `:phoenix_live_view_event_metrics`
    - `:phoenix_live_view_component_event_metrics`

    To use plugin in your application, add the following to your PromEx module:
    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          PromEx.Plugins.PhoenixLiveView
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "phoenix_live_view.json"}
        ]
      end
    end
    ```
    """

    use PromEx.Plugin

    require Logger

    alias Phoenix.Socket
    alias Plug.Conn

    @live_view_mount_stop [:phoenix, :live_view, :mount, :stop]
    @live_view_mount_exception [:phoenix, :live_view, :mount, :exception]

    @live_view_handle_event_stop [:phoenix, :live_view, :handle_event, :stop]
    @live_view_handle_event_exception [:phoenix, :live_view, :handle_event, :exception]

    @live_view_handle_params_stop [:phoenix, :live_view, :handle_params, :stop]
    @live_view_handle_params_exception [:phoenix, :live_view, :handle_params, :exception]

    @live_component_handle_event_stop [:phoenix, :live_component, :handle_event, :stop]
    @live_component_handle_event_exception [:phoenix, :live_component, :handle_event, :exception]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :phoenix_live_view)

      # Event metrics definitions
      [
        live_view_event_metrics(metric_prefix),
        live_component_event_metrics(metric_prefix)
      ]
    end

    defp live_view_event_metrics(metric_prefix) do
      bucket_intervals = [10, 100, 250, 500, 1_000, 2_000, 5_000, 10_000]

      Event.build(
        :phoenix_live_view_event_metrics,
        [
          distribution(
            metric_prefix ++ [:mount, :duration, :milliseconds],
            event_name: @live_view_mount_stop,
            measurement: :duration,
            description: "The time it takes for the live view to complete the mount callback.",
            reporter_options: [
              buckets: bucket_intervals
            ],
            tag_values: &get_socket_tags/1,
            tags: [:action, :module],
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:mount, :exception, :duration, :milliseconds],
            event_name: @live_view_mount_exception,
            measurement: :duration,
            description:
              "The time it takes for the live view to complete the mount callback that resulted in an exception",
            reporter_options: [
              buckets: bucket_intervals
            ],
            tag_values: &get_socket_exception_tags/1,
            tags: [:action, :module, :kind, :reason],
            unit: {:native, :millisecond}
          )
        ]
      )
    end

    defp live_component_event_metrics(metric_prefix) do
      Event.build(
        :phoenix_live_view_component_event_metrics,
        []
      )
    end

    defp get_socket_tags(%{socket: socket = %Phoenix.LiveView.Socket{}}) do
      %{
        action: Map.get(socket.assigns, :live_action, :unknown),
        module: socket.assigns |> Map.get(:live_module, :unknown) |> normalize_module_name()
      }
    end

    defp get_socket_exception_tags(%{socket: socket = %Phoenix.LiveView.Socket{}, kind: kind, reason: reason}) do
      %{
        action: Map.get(socket.assigns, :live_action, :unknown),
        module: socket.assigns |> Map.get(:live_module, :unknown) |> normalize_module_name(),
        kind: kind,
        reason: reason
      }
    end

    defp normalize_module_name(name) when is_atom(name) do
      name
      |> Atom.to_string()
      |> String.trim_leading("Elixir.")
    end

    defp normalize_module_name(name), do: name
  end
else
  defmodule PromEx.Plugins.PhoenixLiveView do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "PhoenixLiveView")
    end
  end
end
