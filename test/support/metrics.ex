defmodule PromEx.Test.Support.Metrics do
  @moduledoc false

  @doc false
  @spec read(atom | String.t()) :: [String.t()]
  def read(plugin) do
    [File.cwd!(), "test", "support", "metrics", "#{plugin}.txt"]
    |> Path.join()
    |> File.read!()
    |> sort()
  end

  @doc false
  @spec sort(String.t()) :: [String.t()]
  def sort(metrics_string) do
    metrics_string
    |> String.split("\n", trim: true)
    |> Enum.sort()
  end
end
