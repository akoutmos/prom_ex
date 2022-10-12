defmodule PromEx.Test.Support.Metrics do
  @moduledoc false

  import ExUnit.Assertions

  @doc false
  @spec read_expected(atom | String.t()) :: [String.t()]
  def read_expected(plugin) do
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

  @doc false
  @spec assert_prom_ex_metics(module(), atom()) :: :ok
  def assert_prom_ex_metics(prom_ex_module, expected_metrics_lookup) do
    collected_metrics =
      prom_ex_module
      |> PromEx.get_metrics()
      |> sort()

    expected_metrics = read_expected(expected_metrics_lookup)

    assert length(collected_metrics) == length(expected_metrics)

    collected_metrics
    |> Enum.zip(expected_metrics)
    |> Enum.each(fn {collected_line, expected_line} ->
      assert collected_line == expected_line
    end)
  end
end
