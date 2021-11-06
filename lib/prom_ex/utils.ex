defmodule PromEx.Utils do
  @moduledoc """
  This module prodvides several general purpose utilities
  for use in PromEx plugs.
  """

  @doc """
  Take a module name and normalize it for use as a metric
  label.
  """
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
  def normalize_exception(:error, reason, stacktrace) do
    %reason{} = Exception.normalize(:error, reason, stacktrace)
    normalize_module_name(reason)
  end

  def normalize_exception(:exit, {reason, _details}, stacktrace) do
    reason
    |> Atom.to_string()
    |> Macro.camelize()
    |> normalize_module_name()
  end

  def normalize_exception(:exit, _reason, stacktrace) do
    "Exit"
  end

  def normalize_exception(:throw, reason, stacktrace) do
    "Throw"
  end
end
