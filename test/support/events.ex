defmodule PromEx.Test.Support.Events do
  @moduledoc false

  @doc false
  @spec execute_all(atom | String.t()) :: :ok
  def execute_all(plugin) do
    [File.cwd!(), "test", "support", "events", "#{plugin}.exs"]
    |> Path.join()
    |> Code.eval_file()
    |> elem(0)
    |> Enum.each(&:telemetry.execute(&1.event, &1.measurements, &1.metadata))
  end
end
