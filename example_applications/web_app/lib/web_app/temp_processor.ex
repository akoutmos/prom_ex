defmodule WebApp.TempProcessor do
  @moduledoc false

  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      hibernate_after: 50_000,
      producer: [
        module: {WebApp.CityProducer, []},
        transformer: {__MODULE__, :transform, []},
        rate_limiting: [
          allowed_messages: 60,
          interval: 30_000
        ]
      ],
      processors: [
        default: [concurrency: 5]
      ],
      batchers: [
        batch_temp: [concurrency: 2, batch_size: 15, batch_timeout: 15_000]
      ]
    )
  end

  @impl true
  def handle_message(:default, message, _context) do
    message
    |> Message.update_data(fn {city, country} ->
      # Simulate some work and some random errors
      random_num = Enum.random(0..2_000)

      if random_num > 100 do
        Process.sleep(random_num)
      else
        Process.sleep(floor(1_000 / 0))
      end

      city_data = {city, country, Enum.random(0..110)}

      WebApp.TempTracker.update_coldest_city(city_data)
    end)
    |> Message.put_batcher(:batch_temp)
  end

  @impl true
  def handle_batch(:batch_temp, messages, _batch_info, _context) do
    # Simulate some work and some random errors
    random_num = Enum.random(0..2_000)

    if random_num > 100 do
      Process.sleep(random_num)
    else
      Process.sleep(floor(1_000 / 0))
    end

    messages
  end

  def transform(event, _opts) do
    %Message{
      data: event,
      acknowledger: {__MODULE__, :ack_id, :ack_data}
    }
  end

  def ack(:ack_id, _successful, _failed) do
    :ok
  end
end
