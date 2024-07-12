defmodule PromEx.Plugins.BroadwayTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Event
  alias PromEx.Plugins.Broadway
  alias PromEx.Test.Support.{Events, Metrics}
  alias Telemetry.Metrics.Distribution

  @default_metadata %{
    processor_key: :default,
    topology_name: Elixir.SomeModule,
    message: %Elixir.Broadway.Message{acknowledger: {Elixir.SomeAcker}, data: %{}}
  }

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [Broadway]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:broadway)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :broadway)
  end

  describe "event_metrics/1" do
    test "returns topology_name for message tags" do
      metric = assert_event_metric(:broadway_message_event_metrics, [:broadway, :processor, :message, :stop])
      assert %{name: "SomeModule", processor_key: :default} = metric.tag_values.(@default_metadata)
    end

    test "returns topology_name for message exception tags" do
      metric = assert_event_metric(:broadway_message_event_metrics, [:broadway, :processor, :message, :exception])
      exception_metadata = Map.merge(@default_metadata, %{kind: Error, reason: "notsure", stacktrace: []})
      assert %{name: "SomeModule", processor_key: :default} = metric.tag_values.(exception_metadata)
    end

    defp assert_event_metric(metric_group, event) do
      assert event_metrics = Broadway.event_metrics(otp_app: :web_app)

      assert %Event{metrics: message_metrics} =
               Enum.find(event_metrics, fn metrics -> metrics.group_name == metric_group end)

      assert %Distribution{} = metric = Enum.find(message_metrics, fn dist -> dist.event_name == event end)

      metric
    end
  end
end
