defmodule PromEx.Plugin do
  @moduledoc """
  This module defines the behaviour that PromEx plugins need to implement
  in order to be properly loaded by PromEx on application start. As a convenience, this
  module can also be used as a macro to automatically import all of the necessary utility
  functions for writing plugins and also providing default implementations of behaviour
  functions that you may not be implementing.
  """

  alias PromEx.MetricTypes.{
    Event,
    Manual,
    Polling
  }

  @doc """
  The `c:event_metrics/1` callback returns the configured event based metrics that the
  plugin exposes. If the plugin does not expose any event style metrics, there is a
  default implementation of this function that returns an empty list. In other words,
  if your plugin does not expose any event style metrics, there is no action needed
  on your part.

  This function is expected to either return a single `PromEx.Plugins.Event` struct
  or a list of `PromEx.Plugins.Event` structs.
  """
  @callback event_metrics(keyword()) :: [Event.t()] | Event.t()

  @doc """
  The `c:polling_metrics/1` callback returns the configured polling based metrics that the
  plugin exposes. If the plugin does not expose any polling style metrics, there is a
  default implementation of this function that returns an empty list. In other words,
  if your plugin does not expose any polling style metrics, there is no action needed
  on your part.

  This function is expected to either return a single `PromEx.Plugins.Polling` struct
  or a list of `PromEx.Plugins.Polling` structs.
  """
  @callback polling_metrics(keyword()) :: [Polling.t()] | Polling.t()

  @doc """
  The `c:manual_metrics/1` callback returns the configured manual based metrics that the
  plugin exposes. If the plugin does not expose any manual style metrics, there is a
  default implementation of this function that returns an empty list. In other words,
  if your plugin does not expose any manual style metrics, there is no action needed
  on your part.

  This function is expected to either return a single `PromEx.Plugins.Manual` struct
  or a list of `PromEx.Plugins.Manual` structs.
  """
  @callback manual_metrics(keyword()) :: [Manual.t()] | Manual.t()

  defmacro __using__(_) do
    quote do
      @behaviour PromEx.Plugin

      import Telemetry.Metrics, only: [counter: 2, distribution: 2, last_value: 2, sum: 2]
      import PromEx.BucketGenerator

      alias PromEx.MetricTypes.{Event, Manual, Polling}

      @doc false
      @impl true
      def event_metrics(_), do: []

      @doc false
      @impl true
      def polling_metrics(_), do: []

      @doc false
      @impl true
      def manual_metrics(_), do: []

      defoverridable PromEx.Plugin
    end
  end

  @doc false
  def no_dep_raise(module, dep) do
    raise("You are attempting to use the #{inspect(module)} plugin but #{dep} is currently not a project dependency")
  end
end
