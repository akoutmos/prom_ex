if Code.ensure_loaded?(Absinthe) do
  defmodule PromEx.Plugins.Absinthe do
    @moduledoc """
    This plugin captures metrics emitted by Absinthe. Specifically, it captures timings and metrics
    around execution times, query complexity, and subscription timings. In order to get complexity
    metrics you'll need to make sure that you have `:analyze_complexity` enabled in
    [Absinthe.Plug](https://hexdocs.pm/absinthe_plug/Absinthe.Plug.html#t:opts/0). This plugin can
    generate a large amount of Prometheus series, so it is suggested that you use the
    `ignored_entrypoints` and `only_entrypoints` (TODO: coming soon) options to prune down the
    resulting metrics if needed.

    This plugin supports the following options:
    - `ignored_entrypoints`: This option is OPTIONAL and is used to filter out Absinthe GraphQL
      schema entrypoints that you do not want to track metrics for. For example, if you don't want
      metrics on the `:__schema` entrypoint (used for GraphQL schema introspection), you would set
      a value of `[:__schema]`. This is applicable to queries, mutations, and subscriptions.

    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
      `[otp_app, :prom_ex, :absinthe]`. If this changes you will also want to set `absinthe_metric_prefix`
      in your `dashboard_assigns` to the snakecase version of your prefix, the default
      `absinthe_metric_prefix` is `{otp_app}_prom_ex_absinthe`.

    This plugin exposes the following metric groups:
    - `:absinthe_execute_event_metrics`
    - `:absinthe_subscription_event_metrics`

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

    # @operation_execute_start_event [:absinthe, :execute, :operation, :start]
    @operation_execute_stop_event [:absinthe, :execute, :operation, :stop]
    # @subscription_publish_start_event [:absinthe, :subscription, :publish, :start]
    @subscription_publish_stop_event [:absinthe, :subscription, :publish, :stop]
    # @resolve_field_start_event [:absinthe, :resolve, :field, :start]
    # @resolve_field_stop_event [:absinthe, :resolve, :field, :stop]
    # @middleware_batch_start_event [:absinthe, :middleware, :batch, :start]
    # @middleware_batch_stop_event [:absinthe, :middleware, :batch, :stop]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :absinthe))

      # Event metrics definitions
      [
        operation_execute_events(metric_prefix, opts),
        subscription_publish_events(metric_prefix, opts)
      ]
    end

    defp subscription_publish_events(metric_prefix, opts) do
      # Fetch user options
      ignored_entrypoints =
        opts
        |> Keyword.get(:ignored_entrypoints, [])
        |> MapSet.new()

      event_tags = [:schema, :operation_type, :entrypoint]

      Event.build(
        :absinthe_subscription_event_metrics,
        [
          # Capture GraphQL request duration information
          distribution(
            metric_prefix ++ [:subscription, :duration, :milliseconds],
            event_name: @subscription_publish_stop_event,
            measurement: :duration,
            description: "The time it takes for the Absinthe to publish subscription data.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            tag_values: &subscription_stop_tag_values/1,
            tags: event_tags,
            unit: {:native, :millisecond},
            drop: entrypoint_in_ignore_set?(ignored_entrypoints)
          )
        ]
      )
    end

    defp operation_execute_events(metric_prefix, opts) do
      # Fetch user options
      ignored_entrypoints =
        opts
        |> Keyword.get(:ignored_entrypoints, [])
        |> MapSet.new()

      event_tags = [:schema, :operation_type, :entrypoint]

      Event.build(
        :absinthe_execute_event_metrics,
        [
          # Capture GraphQL request duration information
          distribution(
            metric_prefix ++ [:execute, :duration, :milliseconds],
            event_name: @operation_execute_stop_event,
            measurement: :duration,
            description: "The time it takes for the Absinthe to complete the operation.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            tag_values: &operation_execute_stop_tag_values/1,
            tags: event_tags,
            unit: {:native, :millisecond},
            drop: entrypoint_in_ignore_set?(ignored_entrypoints)
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
              buckets: [10, 50, 100, 200, 500]
            ],
            tag_values: &operation_execute_stop_tag_values/1,
            tags: event_tags,
            drop: fn metadata ->
              metadata.blueprint
              |> Absinthe.Blueprint.current_operation()
              |> case do
                nil ->
                  true

                current_operation ->
                  entrypoint = entrypoint_from_current_operation(current_operation)
                  MapSet.member?(ignored_entrypoints, entrypoint) or is_nil(current_operation.complexity)
              end
            end
          ),

          # Count Absinthe executions that resulted in errors
          counter(
            metric_prefix ++ [:execute, :invalid, :request, :count],
            event_name: @operation_execute_stop_event,
            tag_values: &operation_execute_stop_tag_values/1,
            tags: [:schema],
            keep: fn metadata ->
              metadata.blueprint.execution.validation_errors != []
            end
          )
        ]
      )
    end

    defp entrypoint_in_ignore_set?(ignored_entrypoints) do
      fn metadata ->
        metadata.blueprint
        |> Absinthe.Blueprint.current_operation()
        |> case do
          nil ->
            true

          current_operation ->
            entrypoint = entrypoint_from_current_operation(current_operation)
            MapSet.member?(ignored_entrypoints, entrypoint)
        end
      end
    end

    defp subscription_stop_tag_values(metadata) do
      metadata.blueprint
      |> Absinthe.Blueprint.current_operation()
      |> case do
        nil ->
          %{
            schema: :unknown,
            operation_type: :unknown,
            entrypoint: :unknown
          }

        current_operation ->
          %{
            schema: normalize_module_name(current_operation.schema_node.definition),
            operation_type: Map.get(current_operation, :type, :unknown),
            entrypoint: entrypoint_from_current_operation(current_operation)
          }
      end
    end

    defp operation_execute_stop_tag_values(metadata) do
      metadata.blueprint
      |> Absinthe.Blueprint.current_operation()
      |> case do
        nil ->
          schema =
            metadata.options
            |> Keyword.get(:schema, :unknown)
            |> normalize_module_name()

          %{
            schema: schema,
            operation_type: :unknown,
            entrypoint: :unknown
          }

        current_operation ->
          %{
            schema: normalize_module_name(current_operation.schema_node.definition),
            operation_type: Map.get(current_operation, :type, :unknown),
            entrypoint: entrypoint_from_current_operation(current_operation)
          }
      end
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
