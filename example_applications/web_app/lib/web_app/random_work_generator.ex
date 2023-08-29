defmodule WebApp.RandomWorkGenerator do
  @moduledoc false

  use GenServer

  require Logger

  alias WebApp.Jobs

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(opts) do
    schedule_work()

    {:ok, opts}
  end

  @impl true
  def handle_info(:do_work, state) do
    # Enqueue work
    enqueue_default_prefix()
    enqueue_secret_prefix()

    schedule_work()
    {:noreply, state}
  end

  def handle_info({_, :ok}, state) do
    {:noreply, state}
  end

  def handle_info({:DOWN, _ref, :process, _pid, :normal}, state) do
    {:noreply, state}
  end

  def handle_info(error, state) do
    Logger.warning("Failed to enqueue Oban work: #{inspect(error)}")

    {:noreply, state}
  end

  defp schedule_work do
    random_delay = Enum.random(1_000..5_000)
    Process.send_after(self(), :do_work, random_delay)
  end

  defp enqueue_default_prefix do
    # Enqueue the default jobs
    Task.async(fn ->
      random_amount = Enum.random(1..20)

      1..random_amount
      |> Enum.each(fn _ ->
        random_sleep = Enum.random(100..2_000)

        %{sleep_time: random_sleep}
        |> Jobs.DefaultWorker.new()
        |> Oban.insert()
      end)
    end)

    # Enqueue the media jobs
    Task.async(fn ->
      random_amount = Enum.random(1..20)

      1..random_amount
      |> Enum.each(fn _ ->
        random_sleep = Enum.random(100..2_000)

        %{sleep_time: random_sleep}
        |> Jobs.MediaWorker.new()
        |> Oban.insert()
      end)
    end)

    # Enqueue the event jobs
    Task.async(fn ->
      random_amount = Enum.random(1..20)

      1..random_amount
      |> Enum.each(fn _ ->
        random_sleep = Enum.random(100..2_000)

        %{sleep_time: random_sleep}
        |> Jobs.EventWorker.new()
        |> Oban.insert()
      end)
    end)
  end

  defp enqueue_secret_prefix do
    # Enqueue the default jobs
    Task.async(fn ->
      random_amount = Enum.random(1..20)

      1..random_amount
      |> Enum.each(fn _ ->
        random_sleep = Enum.random(10..5_000)

        job =
          %{sleep_time: random_sleep}
          |> Jobs.DefaultWorker.new()

        Oban.insert(Oban.SuperSecret, job)
      end)
    end)

    # Enqueue the media jobs
    Task.async(fn ->
      random_amount = Enum.random(1..20)

      1..random_amount
      |> Enum.each(fn _ ->
        random_sleep = Enum.random(10..5_000)

        job =
          %{sleep_time: random_sleep}
          |> Jobs.MediaWorker.new()

        Oban.insert(Oban.SuperSecret, job)
      end)
    end)

    # Enqueue the event jobs
    Task.async(fn ->
      random_amount = Enum.random(1..20)

      1..random_amount
      |> Enum.each(fn _ ->
        random_sleep = Enum.random(10..5_000)

        job =
          %{sleep_time: random_sleep}
          |> Jobs.EventWorker.new()

        Oban.insert(Oban.SuperSecret, job)
      end)
    end)
  end
end
