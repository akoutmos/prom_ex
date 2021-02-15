defmodule PromEx.TelemetryMetricsPrometheus.Core.Counter do
  @moduledoc false

  alias Telemetry.Metrics
  alias PromEx.TelemetryMetricsPrometheus.Core.EventHandler

  @type config :: %{
          keep: Metrics.keep(),
          measurement: atom(),
          metric_name: String.t(),
          name: Metrics.normalized_metric_name(),
          table: atom(),
          tags: Metrics.tags(),
          tag_values_fun: Metrics.tag_values(),
          type: :counter
        }

  @spec register(metric :: Metrics.Counter.t(), table_id :: atom(), owner :: pid()) ::
          {:ok, :telemetry.handler_id()} | {:error, :already_exists}

  def register(metric, table_id, owner) do
    handler_id = EventHandler.handler_id(metric.name, owner)

    with :ok <-
           :telemetry.attach(
             handler_id,
             metric.event_name,
             &__MODULE__.handle_event/4,
             %{
               keep: metric.keep,
               metric_name: "",
               name: metric.name,
               table: table_id,
               tags: metric.tags,
               tag_values_fun: metric.tag_values,
               type: :counter
             }
           ) do
      {:ok, handler_id}
    else
      {:error, :already_exists} = error ->
        error
    end
  end

  @spec handle_event(
          :telemetry.event_name(),
          :telemetry.event_measurements(),
          :telemetry.event_metadata(),
          config()
        ) :: :ok

  def handle_event(_event, _measurements, metadata, config) do
    with true <- EventHandler.keep?(config.keep, metadata),
         mapped_values <- config.tag_values_fun.(metadata),
         :ok <- EventHandler.validate_tags_in_tag_values(config.tags, mapped_values) do
      labels = Map.take(mapped_values, config.tags)
      key = {config.name, labels}
      _res = :ets.update_counter(config.table, key, 1, {key, 0})
      :ok
    else
      false -> :ok
      error -> EventHandler.handle_event_error(error, config)
    end
  end
end
