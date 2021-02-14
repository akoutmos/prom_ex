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
      [:event_metrics, :manual_metrics, :polling_metrics]
      |> Enum.flat_map(&get_metrics(module, &1, args))
      |> MapSet.new()
      |> MapSet.to_list()

    Supervisor.child_spec({WebApp.Recorder, metrics}, id: Module.concat(module, Recorder))
  end

  defp configure_child(module) do
    configure_child({module, []})
  end

  defp get_metrics(module, type, args) do
    module
    |> apply(type, [[{:otp_app, :web_app} | args]])
    |> case do
      %{} = metric -> [metric]
      metrics -> metrics
    end
    |> Enum.flat_map(fn %{metrics: metrics} ->
      Enum.map(metrics, & &1.name)
    end)
  end
end
