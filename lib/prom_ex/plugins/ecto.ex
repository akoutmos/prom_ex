if Code.ensure_loaded?(Ecto) do
  defmodule PromEx.Plugins.Ecto do
    @moduledoc """
    This plugin captures metrics emitted by Ecto. Be sure that your PromEx module is listed before your Repo module
    in your supervision tree so that the Ecto init events are not missed. If you miss those events the dashboard
    variable dropdowns for the repo value will be broken.

    This plugin supports the following options:
    - `otp_app`: This is an OPTIONAL option and is the name of you application in snake case (e.g. :my_cool_app). By
      default the otp_app set for the prom_ex module that this plugin is defined in is used.

    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
      `[otp_app, :prom_ex, :ecto]`. If this changes you will also want to set `ecto_metric_prefix`
      in your `dashboard_assigns` to the snakecase version of your prefix, the default
      `ecto_metric_prefix` is `{otp_app}_prom_ex_ecto`.

    - `repos`: This is an OPTIONAL option and is a list with the full module name of your Ecto Repos (e.g [MyApp.Repo]).
       If you do not provide this value, PromEx will attempt to resolve your Repo modules via the
       `:ecto_repos` configuration on your OTP app.

    This plugin exposes the following metric groups:
    - `:ecto_init_event_metrics`
    - `:ecto_query_event_metrics`

    To use plugin in your application, add the following to your PromEx module `plugins/0` function:
    ```
    def plugins do
      [
        ...

        {PromEx.Plugins.Ecto, otp_app: :web_app, repos: [WebApp.Repo]}
      ]
    end

    ```
    """

    use PromEx.Plugin

    @init_event [:ecto, :repo, :init]
    @query_event [:prom_ex, :plugin, :ecto, :query]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :ecto))

      repo_event_prefixes =
        opts
        |> Keyword.get_lazy(:repos, fn ->
          Application.get_env(otp_app, :ecto_repos)
        end)
        |> Enum.map(fn repo ->
          otp_app
          |> Application.get_env(repo)
          |> Keyword.get_lazy(:telemetry_prefix, fn ->
            telemetry_prefix(repo)
          end)
        end)

      # Telemetry metrics will emit warnings if multiple handlers with the same names are defined.
      # As a result, this plugin supports gathering metrics on multiple repos, but needs to proxy
      # them as not to create multiple definitions of the same metrics. The final data point will
      # have a label for the Repo associated with the event though so you'll be able to separate one
      # repos measurements from another.
      set_up_telemetry_proxy(repo_event_prefixes)

      # Event metrics definitions
      [
        init_metrics(metric_prefix),
        query_metrics(metric_prefix)
      ]
    end

    @doc false
    def handle_proxy_query_event(_event_name, event_measurement, event_metadata, _config) do
      :telemetry.execute(@query_event, event_measurement, event_metadata)
    end

    # Generate the default telemetry prefix
    defp telemetry_prefix(repo) do
      repo
      |> Module.split()
      |> Enum.map(&(&1 |> Macro.underscore() |> String.to_atom()))
    end

    defp init_metrics(metric_prefix) do
      Event.build(
        :ecto_init_event_metrics,
        [
          last_value(
            metric_prefix ++ [:repo, :init, :status, :info],
            event_name: @init_event,
            description: "Information regarding the initialized repo.",
            measurement: fn _measurements -> 1 end,
            tags: [:repo, :database_name, :database_host],
            tag_values: &ecto_init_tag_values/1
          ),
          last_value(
            metric_prefix ++ [:repo, :init, :pool, :size],
            event_name: @init_event,
            description: "The configured pool size value for the repo.",
            measurement: fn _measurements, %{opts: opts} ->
              Keyword.get(opts, :pool_size)
            end,
            tags: [:repo],
            tag_values: &ecto_init_tag_values/1
          ),
          last_value(
            metric_prefix ++ [:repo, :init, :timeout, :duration],
            event_name: @init_event,
            description: "The configured timeout value for the repo.",
            measurement: fn _measurements, %{opts: opts} ->
              Keyword.get(opts, :timeout)
            end,
            tags: [:repo],
            tag_values: &ecto_init_tag_values/1
          )
        ]
      )
    end

    defp query_metrics(metric_prefix) do
      Event.build(
        :ecto_query_event_metrics,
        [
          # Capture the db connection idle time
          distribution(
            metric_prefix ++ [:repo, :query, :idle, :time, :milliseconds],
            event_name: @query_event,
            measurement: :idle_time,
            description: "The time the connection spent waiting before being checked out for the query.",
            tags: [:repo],
            tag_values: &ecto_query_tag_values/1,
            reporter_options: [
              buckets: [10, 50, 250, 1_000, 5_000, 10_000]
            ],
            unit: {:native, :millisecond}
          ),

          # Capture the db connection queue time
          distribution(
            metric_prefix ++ [:repo, :query, :queue, :time, :milliseconds],
            event_name: @query_event,
            measurement: :queue_time,
            description: "The time spent waiting to check out a database connection.",
            tags: [:repo],
            tag_values: &ecto_query_tag_values/1,
            reporter_options: [
              buckets: [10, 50, 250, 1_000, 5_000, 10_000]
            ],
            unit: {:native, :millisecond}
          ),

          # Capture the db query decode time
          distribution(
            metric_prefix ++ [:repo, :query, :decode, :time, :milliseconds],
            event_name: @query_event,
            measurement: :decode_time,
            description: "The time spent decoding the data received from the database.",
            tags: [:repo],
            tag_values: &ecto_query_tag_values/1,
            reporter_options: [
              buckets: [5, 50, 100, 500, 2_500]
            ],
            unit: {:native, :millisecond}
          ),

          # Capture the query execution time
          distribution(
            metric_prefix ++ [:repo, :query, :execution, :time, :milliseconds],
            event_name: @query_event,
            measurement: :query_time,
            description: "The time spent executing the query.",
            tags: [:repo, :source, :command],
            tag_values: &ecto_query_tag_values/1,
            reporter_options: [
              buckets: [10, 50, 250, 2_500, 10_000, 30_000]
            ],
            unit: {:native, :millisecond}
          ),

          # Capture the total time (the sum of all other measurements)
          distribution(
            metric_prefix ++ [:repo, :query, :total, :time, :milliseconds],
            event_name: @query_event,
            measurement: :total_time,
            description: "The sum of the other time measurements.",
            tags: [:repo, :source, :command],
            tag_values: &ecto_query_tag_values/1,
            reporter_options: [
              buckets: [10, 50, 250, 2_500, 10_000, 30_000]
            ],
            unit: {:native, :millisecond}
          ),

          # Capture the number of results returned
          distribution(
            metric_prefix ++ [:repo, :query, :results, :returned],
            event_name: @query_event,
            measurement: fn _measurement, %{result: result} ->
              normalize_results_returned(result)
            end,
            description: "The number of result rows returned from a query.",
            tags: [:repo, :source, :command],
            tag_values: &ecto_query_tag_values/1,
            reporter_options: [
              buckets: [5, 10, 50, 100, 500, 1_000]
            ],
            drop: fn %{result: result} ->
              normalize_results_returned(result) == :drop_data_point
            end
          )
        ]
      )
    end

    defp set_up_telemetry_proxy(repo_event_prefixes) do
      repo_event_prefixes
      |> Enum.each(fn telemetry_prefix ->
        query_event = telemetry_prefix ++ [:query]

        :telemetry.attach(
          [:prom_ex, :ecto, :proxy] ++ telemetry_prefix,
          query_event,
          &__MODULE__.handle_proxy_query_event/4,
          %{}
        )
      end)
    end

    defp ecto_init_tag_values(%{repo: repo, opts: opts}) do
      %{
        repo: repo |> Atom.to_string() |> String.trim_leading("Elixir."),
        database_name: Keyword.get(opts, :database),
        database_host: Keyword.get(opts, :hostname)
      }
    end

    defp ecto_query_tag_values(%{repo: repo, source: source, result: result}) do
      %{
        repo: repo |> Atom.to_string() |> String.trim_leading("Elixir."),
        source: normalize_source(source),
        command: normalize_command(result)
      }
    end

    defp normalize_source(nil), do: "source_unavailable"
    defp normalize_source(source) when is_binary(source), do: source
    defp normalize_source(source) when is_atom(source), do: Atom.to_string(source)
    defp normalize_source(_), do: "source_unavailable"

    defp normalize_command({:ok, %_{command: command}}) when is_atom(command) do
      Atom.to_string(command)
    end

    defp normalize_command(_) do
      "unavailable"
    end

    defp normalize_results_returned({:ok, %_{num_rows: num_row}}) when is_integer(num_row) do
      num_row
    end

    defp normalize_results_returned(_) do
      :drop_data_point
    end
  end
else
  defmodule PromEx.Plugins.Ecto do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Ecto")
    end
  end
end
