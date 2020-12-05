unless Code.ensure_loaded?(Ecto) do
  raise "Attempting to use PromEx Ecto plugin when Ecto has not been installed"
end

defmodule PromEx.Plugins.Ecto do
  @moduledoc """
  This plugin captures metrics emitted by Ecto.

  This plugin supports the following options:
  - `repo`: This is a REQUIRED option and is the full module name of your Ecto Repo (e.g MyApp.Repo).

  - `otp_app`: This is a REQUIRED option and is the name of you application in snake case (e.g. :my_cool_app).


  This plugin exposes the following metric groups:
  - `:`

  To use plugin in your application, add the following to your PromEx module `plugins/0` function:
  ```
  def plugins do
    [
      ...

      {PromEx.Plugins.Ecto, otp_app: :web_app, repo: WebApp.Repo}
    ]
  end

  ```
  """

  use PromEx.Plugin

  require Logger

  @impl true
  def event_metrics(opts) do
    repo = Keyword.fetch!(opts, :repo)
    otp_app = Keyword.fetch!(opts, :otp_app)

    telemetry_prefix =
      otp_app
      |> Application.get_env(repo)
      |> Keyword.get_lazy(:telemetry_prefix, fn ->
        telemetry_prefix(repo)
      end)

    init_event = [:ecto, :repo, :init]
    query_event = telemetry_prefix ++ [:query]

    # Event metrics definitions
    [
      init_metrics(init_event),
      query_metrics(query_event)
    ]
  end

  # Generate the default telemetry prefix
  defp telemetry_prefix(repo) do
    repo
    |> Module.split()
    |> Enum.map(&(&1 |> Macro.underscore() |> String.to_atom()))
  end

  defp init_metrics(init_event) do
    Event.build(
      :ecto_init_event_metrics,
      [
        last_value(
          [:ecto, :repo, :init, :status, :info],
          event_name: init_event,
          description: "Information regarding the initialized repo.",
          measurement: fn _measurements -> 1 end,
          tags: [:repo, :database_name, :database_host],
          tag_values: &ecto_init_tag_values/1
        ),
        last_value(
          [:ecto, :repo, :init, :pool, :size],
          event_name: init_event,
          description: "The configured pool size value for the repo.",
          measurement: fn _measurements, %{opts: opts} ->
            Keyword.get(opts, :pool_size)
          end,
          tags: [:repo],
          tag_values: &ecto_init_tag_values/1
        ),
        last_value(
          [:ecto, :repo, :init, :timeout, :duration],
          event_name: init_event,
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

  defp query_metrics(query_event) do
    Event.build(
      :ecto_query_event_metrics,
      [
        # Capture the db connection idle time
        distribution(
          [:ecto, :repo, :query, :idle, :time, :milliseconds],
          event_name: query_event,
          measurement: :idle_time,
          description: "The time the connection spent waiting before being checked out for the query.",
          tags: [:repo],
          tag_values: &ecto_query_tag_values/1,
          reporter_options: [
            buckets: [1, 10, 50, 100, 500, 1_000, 5_000, 10_000]
          ],
          unit: {:native, :millisecond}
        ),

        # Capture the db connection queue time
        distribution(
          [:ecto, :repo, :query, :queue, :time, :milliseconds],
          event_name: query_event,
          measurement: :queue_time,
          description: "The time spent waiting to check out a database connection.",
          tags: [:repo],
          tag_values: &ecto_query_tag_values/1,
          reporter_options: [
            buckets: [1, 10, 50, 100, 500, 1_000, 5_000, 10_000]
          ],
          unit: {:native, :millisecond}
        ),

        # Capture the db query decode time
        distribution(
          [:ecto, :repo, :query, :decode, :time, :milliseconds],
          event_name: query_event,
          measurement: :decode_time,
          description: "The time spent decoding the data received from the database.",
          tags: [:repo],
          tag_values: &ecto_query_tag_values/1,
          reporter_options: [
            buckets: [1, 10, 50, 100, 500, 1_000, 5_000, 10_000]
          ],
          unit: {:native, :millisecond}
        ),

        # Capture the query execution time
        distribution(
          [:ecto, :repo, :query, :execution, :time, :milliseconds],
          event_name: query_event,
          measurement: :query_time,
          description: "The time spent executing the query.",
          tags: [:repo, :source, :command],
          tag_values: &ecto_query_tag_values/1,
          reporter_options: [
            buckets: [1, 10, 50, 100, 500, 1_000, 5_000, 10_000]
          ],
          unit: {:native, :millisecond}
        ),

        # - [ ] Query num results returned (tags include: repo, source, command)
        # Capture the number of results returned
        distribution(
          [:ecto, :repo, :query, :results, :returned],
          event_name: query_event,
          measurement: fn _measurement, %{result: result} ->
            normalize_results_returned(result)
          end,
          description: "The time spent executing the query.",
          tags: [:repo, :source, :command],
          tag_values: &ecto_query_tag_values/1,
          reporter_options: [
            buckets: [1, 10, 50, 100, 250, 500, 1_000, 5_000]
          ],
          drop: fn %{result: result} ->
            normalize_results_returned(result) == :drop_data_point
          end
        )
      ]
    )
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

  defp normalize_source(source) when is_binary(source), do: source
  defp normalize_source(source) when is_atom(source), do: Atom.to_string(source)
  defp normalize_source(_), do: "unavailable"

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
