defmodule WebApp.RecorderSupervisor do
  @moduledoc false

  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    WebApp.PromEx.plugins()
    |> Enum.map(&configure_child/1)
    |> Supervisor.init(strategy: :one_for_one)
  end

  defp configure_child({module, args}) do
    metrics =
      [
        :event_metrics,
        :manual_metrics,
        :polling_metrics
      ]
      |> Enum.flat_map(&get_metrics(module, &1, args))
      |> MapSet.new()
      |> MapSet.to_list()

    name = Module.concat(module, Recorder)

    Supervisor.child_spec({WebApp.Recorder, metrics: metrics, name: name}, id: name)
  end

  defp configure_child(module) do
    configure_child({module, []})
  end

  defp get_metrics(module, type, args) do
    module
    |> apply(type, [[{:otp_app, :web_app} | args]])
    |> List.wrap()
    |> Enum.flat_map(fn %{metrics: metrics} ->
      Enum.map(metrics, & &1.event_name)
    end)
  end
end
