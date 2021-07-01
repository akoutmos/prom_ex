if Code.ensure_loaded?(Absinthe) do
  defmodule PromEx.Plugins.Absinthe do
    @moduledoc """
    This plugin captures metrics emitted by Absinthe. Specifically, it captures timings and metrics
    around execution times, query complexity, and subscription timings.

    This plugin supports the following options:
    - `ignored_entrypoints`: This option is OPTIONAL and is used to filter out Absinthe GraphQL
      schema entrypoints that you do not want to track metrics for. For example, if you don't want
      metrics on the `:__schema` entrypoint (used for GraphQL schema introspection), you would set
      a value of `[:__schema]`.

    This plugin exposes the following metric groups:
    - `:absinthe_operation_execute_metrics`

    To use plugin in your application, add the following to your PromEx module:
    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {PromEx.Plugins.Absinthe, ignored_entrypoints: [:__schema]}
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "absinthe.json"}
        ]
      end
    end
    ```
    """

    use PromEx.Plugin

    require Logger

    # @operation_execute_start_event [:absinthe, :execute, :operation, :start]
    @operation_execute_stop_event [:absinthe, :execute, :operation, :stop]
    # @subscription_publish_start_event [:absinthe, :subscription, :publish, :start]
    # @subscription_publish_stop_event [:absinthe, :subscription, :publish, :stop]
    # @resolve_field_start_event [:absinthe, :resolve, :field, :start]
    # @resolve_field_stop_event [:absinthe, :resolve, :field, :stop]
    # @middleware_batch_start_event [:absinthe, :middleware, :batch, :start]
    # @middleware_batch_stop_event [:absinthe, :middleware, :batch, :stop]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :absinthe)

      # Event metrics definitions
      [
        operation_execute_events(metric_prefix, opts)
        # subscription_publish_events(metric_prefix),
        # resolve_field_events(metric_prefix),
        # middleware_batch_events(metric_prefix)
      ]
    end

    defp operation_execute_events(metric_prefix, opts) do
      # Fetch user options
      ignored_entrypoints =
        opts
        |> Keyword.get(:ignored_entrypoints, [])
        |> MapSet.new()

      event_tags = [:schema, :operation_type, :entrypoint]

      Event.build(
        :absinthe_operation_execute_metrics,
        [
          # Capture GraphQL request duration information
          distribution(
            metric_prefix ++ [:execute, :duration, :milliseconds],
            event_name: @operation_execute_stop_event,
            measurement: :duration,
            description: "The time it takes for the Absinthe to complete the operation.",
            reporter_options: [
              buckets: [50, 100, 250, 500, 1_000, 2_500, 5_000, 10_000, 20_000]
            ],
            tag_values: &operation_execute_stop_tag_values/1,
            tags: event_tags,
            unit: {:native, :millisecond},
            drop: fn metadata ->
              entrypoint =
                metadata.blueprint
                |> Absinthe.Blueprint.current_operation()
                |> entrypoint_from_current_operation()

              MapSet.member?(ignored_entrypoints, entrypoint)
            end
          ),

          # Capture GraphQL request complexity
          distribution(
            metric_prefix ++ [:execute, :complexity, :size],
            event_name: @operation_execute_stop_event,
            measurement: fn _measurements, metadata ->
              current_operation = Absinthe.Blueprint.current_operation(metadata.blueprint)
              current_operation.complexity
            end,
            description: "The estimated complexity for a given Absinthe operation.",
            reporter_options: [
              buckets: [5, 10, 25, 50, 100, 200]
            ],
            tag_values: &operation_execute_stop_tag_values/1,
            tags: event_tags,
            drop: fn metadata ->
              current_operation = Absinthe.Blueprint.current_operation(metadata.blueprint)
              entrypoint = entrypoint_from_current_operation(current_operation)

              MapSet.member?(ignored_entrypoints, entrypoint) or is_nil(current_operation.complexity)
            end
          )
        ]
      )
    end

    defp operation_execute_stop_tag_values(metadata) do
      current_operation = Absinthe.Blueprint.current_operation(metadata.blueprint)

      %{
        schema: Keyword.get(metadata.options, :schema, :unknown) |> normalize_module_name(),
        operation_type: current_operation.type || :unknown,
        entrypoint: entrypoint_from_current_operation(current_operation)
      }
    end

    defp entrypoint_from_current_operation(current_operation) do
      current_operation.selections
      |> List.first()
      |> Map.get(:schema_node)
      |> case do
        nil ->
          :invalid_entrypoint

        valid_entrypoint ->
          Map.get(valid_entrypoint, :identifier)
      end
    end

    defp normalize_module_name(name) when is_atom(name) do
      name
      |> Atom.to_string()
      |> String.trim_leading("Elixir.")
    end

    defp normalize_module_name(name), do: name
  end
else
  defmodule PromEx.Plugins.Absinthe do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Absinthe")
    end
  end
end
