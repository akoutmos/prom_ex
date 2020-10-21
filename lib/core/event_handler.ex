defmodule PromEx.TelemetryMetricsPrometheus.Core.EventHandler do
  @moduledoc false

  alias Telemetry.Metrics
  alias PromEx.TelemetryMetricsPrometheus.Core.{Counter, Distribution, LastValue, Sum}

  @typep measurement ::
           atom()
           | (:telemetry.event_measurements() -> number())
           | (:telemetry.event_measurements(), :telemetry.event_metadata() -> number())
  @typep measurement_not_found_error :: {:measurement_not_found, atom()}
  @typep measurement_parse_error :: {:measurement_parse_error, term}
  @typep tags_missing_error :: {:tags_missing, [atom()]}
  @typep event_config ::
           Counter.config() | Distribution.config() | LastValue.config() | Sum.config()

  @typep event_error ::
           measurement_not_found_error | measurement_parse_error | tags_missing_error()

  require Logger

  @spec handler_id(name :: Metrics.normalized_metric_name(), reporter :: pid) ::
          :telemetry.handler_id()
  def handler_id(name, reporter) do
    {__MODULE__, reporter, name}
  end

  @spec keep?(Metrics.keep(), metadata :: :telemetry.event_metadata()) :: boolean()
  def keep?(nil, _metadata), do: true
  def keep?(keep_fun, metadata), do: keep_fun.(metadata)

  @spec validate_tags_in_tag_values(Telemetry.Metrics.tags(), map()) :: :ok | tags_missing_error()
  def validate_tags_in_tag_values(tags, tag_values) do
    case Enum.reject(tags, &match?(%{^&1 => _}, tag_values)) do
      [] -> :ok
      missing_tags -> {:tags_missing, missing_tags}
    end
  end

  @spec get_measurement(
          measurements :: :telemetry.event_measurements(),
          metadata :: :telemetry.event_metadata(),
          measurement()
        ) ::
          {:ok, number()} | measurement_not_found_error() | measurement_parse_error()
  def get_measurement(measurements, _metadata, measurement) when is_atom(measurement) do
    case Map.get(measurements, measurement) do
      nil -> {:measurement_not_found, measurement}
      value -> parse_measurement(value)
    end
  end

  def get_measurement(measurements, _metadata, measurement_fun)
      when is_function(measurement_fun, 1) do
    measurements
    |> measurement_fun.()
    |> parse_measurement()
  end

  def get_measurement(measurements, metadata, measurement_fun)
      when is_function(measurement_fun, 2) do
    measurements
    |> measurement_fun.(metadata)
    |> parse_measurement()
  end

  # Not sure if we should be handling this. Should reporters be responsible for bad actors?
  @spec parse_measurement(term) :: {:ok, number()} | no_return()
  def parse_measurement(measurement) when is_number(measurement), do: {:ok, measurement}
  def parse_measurement(term), do: {:measurement_parse_error, term}

  @spec handle_event_error(event_error(), event_config) :: no_return()
  def handle_event_error({:measurement_not_found, measurement}, config) do
    Logger.debug("Measurement not found, expected: #{measurement}. metric_name:=#{inspect(config.name)}")
  end

  def handle_event_error({:measurement_parse_error, nil}, _config), do: :ok

  def handle_event_error({:measurement_parse_error, term}, config) do
    Logger.debug("Expected measurement to be a number, got: #{inspect(term)}. metric_name:=#{inspect(config.name)}")
  end

  def handle_event_error({:tags_missing, tags}, config) do
    Logger.debug("Tags missing from tag_values. metric_name:=#{inspect(config.name)} tags:=#{inspect(Enum.join(tags))}")
  end
end
