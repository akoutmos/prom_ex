defmodule WebApp.Jobs.EventWorker do
  @moduledoc false
  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"sleep_time" => time}}) do
    # TODO: Add some random errors
    Process.sleep(time)

    :ok
  end
end
