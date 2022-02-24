if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule PromEx.Plugins.PhoenixLiveView do
    @moduledoc """
    This plugin captures metrics emitted by PhoenixLiveView. Specifically, it captures events related to the
    mount, handle_event, and handle_params callbacks for live views and live components.

    This plugin supports the following options:
    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
      `[otp_app, :prom_ex, :phoenix_live_view]`. If this changes you will also want to set
      `phoenix_live_view_metric_prefix` in your `dashboard_assigns` to the snakecase version of your
      prefix, the default `phoenix_live_view_metric_prefix` is `{otp_app}_prom_ex_phoenix_live_view`.

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

    alias Phoenix.LiveView.Socket
    alias PromEx.Utils

    @live_view_mount_stop [:phoenix, :live_view, :mount, :stop]
    @live_view_mount_exception [:phoenix, :live_view, :mount, :exception]

    @live_view_handle_event_stop [:phoenix, :live_view, :handle_event, :stop]
    @live_view_handle_event_exception [:phoenix, :live_view, :handle_event, :exception]

    # Coming soon
    # @live_view_handle_params_stop [:phoenix, :live_view, :handle_params, :stop]
    # @live_view_handle_params_exception [:phoenix, :live_view, :handle_params, :exception]

    # Coming soon
    # @live_component_handle_event_stop [:phoenix, :live_component, :handle_event, :stop]
    # @live_component_handle_event_exception [:phoenix, :live_component, :handle_event, :exception]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :phoenix_live_view))

      # Event metrics definitions
      [
        live_view_event_metrics(metric_prefix),
        live_component_event_metrics(metric_prefix)
      ]
    end

    defp live_view_event_metrics(metric_prefix) do
      bucket_intervals = [10, 100, 500, 1_000, 2_500, 5_000, 10_000]

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
            tag_values: &get_mount_socket_tags/1,
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
            tag_values: &get_mount_exception_tags/1,
            tags: [:action, :module, :kind, :reason],
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:handle_event, :duration, :milliseconds],
            event_name: @live_view_handle_event_stop,
            measurement: :duration,
            description: "The time it takes for the live view to complete the handle_event callback.",
            reporter_options: [
              buckets: bucket_intervals
            ],
            tag_values: &get_handle_event_socket_tags/1,
            tags: [:event, :action, :module],
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:handle_event, :exception, :duration, :milliseconds],
            event_name: @live_view_handle_event_exception,
            measurement: :duration,
            description:
              "The time it takes for the live view to complete the handle_event callback that resulted in an exception.",
            reporter_options: [
              buckets: bucket_intervals
            ],
            tag_values: &get_handle_event_exception_socket_tags/1,
            tags: [:event, :action, :module, :kind, :reason],
            unit: {:native, :millisecond}
          )
        ]
      )
    end

    defp live_component_event_metrics(_metric_prefix) do
      Event.build(
        :phoenix_live_view_component_event_metrics,
        []
      )
    end

    defp get_handle_event_exception_socket_tags(%{socket: socket = %Socket{}} = metadata) do
      %{
        event: metadata.event,
        action: get_live_view_action(socket),
        module: get_live_view_module(socket),
        kind: metadata.kind,
        reason: Utils.normalize_exception(metadata.kind, metadata.reason, metadata.stacktrace)
      }
    end

    defp get_handle_event_socket_tags(%{socket: socket = %Socket{}} = metadata) do
      %{
        event: metadata.event,
        action: get_live_view_action(socket),
        module: get_live_view_module(socket)
      }
    end

    defp get_mount_socket_tags(%{socket: socket = %Socket{}}) do
      %{
        action: get_live_view_action(socket),
        module: get_live_view_module(socket)
      }
    end

    defp get_mount_exception_tags(%{socket: socket = %Socket{}} = metadata) do
      %{
        action: get_live_view_action(socket),
        module: get_live_view_module(socket),
        kind: metadata.kind,
        reason: Utils.normalize_exception(metadata.kind, metadata.reason, metadata.stacktrace)
      }
    end

    defp get_live_view_module(%Socket{} = socket) do
      socket
      |> Map.get(:view, :unknown)
      |> normalize_module_name()
    end

    defp get_live_view_action(%Socket{} = socket) do
      socket.assigns
      |> Map.get(:live_action, :unknown)
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
