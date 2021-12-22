defmodule WebApp.TempTracker do
  @moduledoc false

  use Agent

  def start_link(_) do
    Agent.start_link(fn -> nil end, name: __MODULE__)
  end

  def get_coldest_city do
    Agent.get(__MODULE__, fn {city, country, temp} ->
      "The coldest city on earth is currently #{city}, #{country} with a temperature of #{
        kelvin_to_c(temp)
      }°C"
    end)
  end

  def update_coldest_city(:error), do: nil

  def update_coldest_city({_, _, new_temp} = new_data) do
    Agent.update(__MODULE__, fn
      {_, _, orig_temp} = orig_data ->
        if new_temp < orig_temp, do: new_data, else: orig_data

      nil ->
        new_data
    end)
  end

  defp kelvin_to_c(kelvin), do: kelvin - 273.15
end
