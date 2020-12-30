if Code.ensure_loaded?(Oban) do
  defmodule PromEx.Plugins.Oban do
    @moduledoc """
    This plugin captures metrics emitted by Oban. Specifically, it captures metrics from job events, producer events,
    and also from internal polling jobs to monitor queue sizes

    This plugin supports the following options:
    - `queues`: This is a OPTIONAL option and is a list of all the queues that this plugin should monitor. By default,
      this plugin will look at your Oban config and monitor all of the configured queues.

    - `poll_rate`: This is option is OPTIONAL and is the rate at which poll metrics are refreshed (default is 5 seconds).

    This plugin exposes the following metric groups:
    - `:oban_job_event_metrics`
    - `:oban_producer_event_metrics`
    - `:oban_circuit_event_metrics`
    - `:oban_queue_poll_metrics`

    To use plugin in your application, add the following to your PromEx module:
    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {PromEx.Plugins.Oban, queues: [:default, :media, :events], poll_rate: 10_000}
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "oban.json"}
        ]
      end
    end
    ```

    """

    use PromEx.Plugin

    @impl true
    def manual_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :oban)

      # Config details
      []
    end

    @impl true
    def event_metrics(opts) do
      oban_queues = Keyword.get(opts, :queues, :all_queues)
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :oban)

      # Job processing details
      []
    end

    @impl true
    def polling_metrics(opts) do
      poll_rate = Keyword.get(opts, :poll_rate, 5_000)
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :oban)

      # Queue length details
      []
    end
  end
else
  defmodule PromEx.Plugins.Oban do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Oban")
    end
  end
end
