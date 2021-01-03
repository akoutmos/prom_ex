defmodule WebApp.Jobs.DefaultWorker do
  @moduledoc false
  use Oban.Worker

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"sleep_time" => time}}) do
    # Randomly trigger an error to make the graphs exciting
    ran_num = Enum.random(0..4)
    additional_time = ceil(100 / ran_num)
    Process.sleep(time + additional_time)

    :ok
  end
end
