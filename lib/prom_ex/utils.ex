defmodule PromEx.Utils do
  @moduledoc """
  This module prodvides several general purpose utilities
  for use in PromEx plugs.
  """

  @typedoc "The kinds of exceptions that can occur"
  @type exception_kind :: :error | :exit | :throw

  @doc """
  Take a module name and normalize it for use as a metric
  label.
  """
  @spec normalize_module_name(String.t() | atom()) :: String.t()
  def normalize_module_name(name) when is_atom(name) do
    name
    |> Atom.to_string()
    |> String.trim_leading("Elixir.")
  end

  def normalize_module_name(name) do
    String.trim_leading(name, "Elixir.")
  end

  @doc """
  Normalize exception messages for use as metric labels.
  """
  @spec normalize_exception(exception_kind(), term(), term()) :: String.t()
  def normalize_exception(:error, reason, stacktrace) do
    %normalized_reason{} = Exception.normalize(:error, reason, stacktrace)

    normalize_module_name(normalized_reason)
  end

  def normalize_exception(:exit, {reason, _details}, _stacktrace) do
    reason
    |> Atom.to_string()
    |> Macro.camelize()
    |> normalize_module_name()
  end

  def normalize_exception(:exit, _reason, _stacktrace) do
    "UnknownExit"
  end

  def normalize_exception({:EXIT, _pid}, _reason, _stacktrace) do
    "UnknownExit"
  end

  def normalize_exception(:throw, _reason, _stacktrace) do
    "UnknownThrow"
  end

  def normalize_exception(_kind, _reason, _stacktrace) do
    "UnknownException"
  end
end
