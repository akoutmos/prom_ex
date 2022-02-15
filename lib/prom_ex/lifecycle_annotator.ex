defmodule PromEx.LifecycleAnnotator do
  @moduledoc """
  This GenServer is responsible to keeping track of the life cycle
  of the application and sending annotation requests to Grafana
  when the application starts and when it terminates. It will
  include things in the message like:

    - Hostname
    - OTP app name
    - App version
    - Git SHA of the last commit (if the GIT_SHA environment variable is present)
    - Git author of the last commit (if the GIT_AUTHOR environment variable is present)
  """

  use GenServer

  require Logger

  alias PromEx.GrafanaClient

  @doc """
  Used to start the `PromEx.LifecycleAnnotator` process.
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts) do
    {name, remaining_opts} = Keyword.pop(opts, :name)
    state = Map.new(remaining_opts)

    GenServer.start_link(__MODULE__, state, name: name)
  end

  @impl true
  def init(state) do
    # Trap exit so that the stop annotation can be published
    Process.flag(:trap_exit, true)

    {:ok, state, {:continue, :create_startup_annotation}}
  end

  @impl true
  def handle_continue(:create_startup_annotation, %{prom_ex_module: prom_ex_module, otp_app: otp_app} = state) do
    # Collect relevant info for application
    hostname =
      :inet.gethostname()
      |> elem(1)
      |> :erlang.list_to_binary()

    app_version =
      otp_app
      |> Application.spec(:vsn)
      |> to_string()

    git_sha =
      case System.fetch_env("GIT_SHA") do
        {:ok, git_sha} ->
          git_sha

        :error ->
          "Not available"
      end

    git_author =
      case System.fetch_env("GIT_AUTHOR") do
        {:ok, git_sha} ->
          git_sha

        :error ->
          "Not available"
      end

    state =
      state
      |> Map.put(:hostname, hostname)
      |> Map.put(:app_version, app_version)
      |> Map.put(:git_sha, git_sha)
      |> Map.put(:git_author, git_author)

    grafana_conn = GrafanaClient.build_conn(prom_ex_module)

    annotation_details = generate_annotation_details(state)
    annotation_text = ["#{to_string(otp_app)} is starting up\n" | annotation_details] |> Enum.join("\n")

    grafana_conn
    |> GrafanaClient.create_annotation(["prom_ex", to_string(otp_app), "start"], annotation_text)
    |> case do
      {:ok, _response_payload} ->
        Logger.info("PromEx.LifecycleAnnotator successfully created start annotation in Grafana.")

      {:error, reason} ->
        Logger.warn("PromEx.LifecycleAnnotator failed to create start annotation in Grafana: #{inspect(reason)}")
    end

    {:noreply, state}
  end

  @impl true
  def terminate(_reason, %{prom_ex_module: prom_ex_module, otp_app: otp_app} = state) do
    grafana_conn = GrafanaClient.build_conn(prom_ex_module)

    annotation_details = generate_annotation_details(state)
    annotation_text = ["#{to_string(otp_app)} is shutting down\n" | annotation_details] |> Enum.join("\n")

    grafana_conn
    |> GrafanaClient.create_annotation(["prom_ex", to_string(otp_app), "stop"], annotation_text)
    |> case do
      {:ok, _response_payload} ->
        Logger.info("PromEx.LifecycleAnnotator successfully created stop annotation in Grafana.")

      {:error, reason} ->
        Logger.warn("PromEx.LifecycleAnnotator failed to create stop annotation in Grafana: #{inspect(reason)}")
    end

    :ok
  end

  defp generate_annotation_details(state) do
    %{app_version: app_version, hostname: hostname, git_sha: git_sha, git_author: git_author} = state

    [
      "Hostname - #{hostname}",
      "App Version - #{app_version}",
      "Git SHA - #{git_sha}",
      "Git Author - #{git_author}"
    ]
  end
end
