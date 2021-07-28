defmodule PromEx.Plugins.PromEx do
  @moduledoc false

  use PromEx.Plugin

  @impl true
  def manual_metrics(opts) do
    otp_app = Keyword.fetch!(opts, :otp_app)
    metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :prom_ex))

    Manual.build(
      :prom_ex_manual_metrics,
      {__MODULE__, :prom_ex_status, []},
      [
        # Capture information regarding the primary application (i.e the user's application)
        last_value(
          metric_prefix ++ [:status, :info],
          event_name: [:prom_ex, :status, :info],
          description:
            "Information regarding the PromEx library. Primarily used as a source of truth for Prometheus default labels.",
          measurement: :status
        )
      ]
    )
  end

  @doc false
  def prom_ex_status do
    :telemetry.execute([:prom_ex, :status, :info], %{status: 1}, %{})
  end
end
