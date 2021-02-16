defmodule WebAppWeb.EventController do
  use WebAppWeb, :controller

  def index(conn, %{"plugin" => plugin}) do
    recorders = recorders()

    recorders
    |> Map.get(String.downcase(plugin))
    |> case do
      nil ->
        options =
          recorders
          |> Map.keys()
          |> Enum.join(", ")

        text(conn, "Unknown plugin: #{plugin}. Try one of #{options}")

      recorder ->
        events =
          recorder
          |> WebApp.Recorder.get_events()
          |> format()

        text(conn, events)
    end
  end

  def index(conn, _) do
    events =
      WebApp.RecorderSupervisor
      |> Supervisor.which_children()
      |> Map.new(fn {id, pid, _type, _modules} ->
        {id, WebApp.Recorder.get_events(pid)}
      end)
      |> format()

    text(conn, events)
  end

  defp format(list) do
    inspect(list,
      limit: :infinity,
      pretty: true,
      printable_limit: :infinity,
      structs: false
    )
  end

  defp recorders do
    Map.new(WebApp.PromEx.plugins(), &pair/1)
  end

  defp pair({module, _}) do
    pair(module)
  end

  defp pair(module) when is_atom(module) do
    key =
      module
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    server = Module.concat(module, Recorder)
    {key, server}
  end
end
