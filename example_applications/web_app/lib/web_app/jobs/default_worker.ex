defmodule WebApp.Jobs.DefaultWorker do
  @moduledoc false
  use Oban.Worker

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"sleep_time" => time}}) do
    Process.sleep(time)

    :ok
  end
end
