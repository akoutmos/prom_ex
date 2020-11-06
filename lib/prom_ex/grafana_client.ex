defmodule PromEx.GrafanaClient do
  @moduledoc """
  This module is used by the Mix tasks that are available in PromEx to update
  dashboards in Grafana and also by the `PromEx.DashboardUpdater` to update
  dashboards automatically on application initialization.
  """

  require Logger

  @doc """
  Used to create a new dashboard or update an existing dashboard
  """
  @spec create_or_update_dashboard(
          finch_process_name :: atom(),
          base_url :: String.t(),
          bearer_token :: String.t(),
          dashboard_file_path :: String.t()
        ) :: :ok
  def(create_or_update_dashboard(finch_process_name, base_url, bearer_token, dashboard_file_path)) do
    case File.read(dashboard_file_path) do
      {:ok, dashboard_contents} ->
        headers = grafana_headers(bearer_token)

        payload = generate_dashboard_payload(dashboard_contents)

        :post
        |> Finch.build("#{base_url}/api/dashboards/db", headers, payload)
        |> Finch.request(finch_process_name)

        :ok

      {:error, reason} ->
        Logger.warn("Failed to read file #{dashboard_file_path} because of reason: #{inspect(reason)}")
        {:error, :invalid_dashboard}
    end
  end

  # @doc """
  # Used to create a folder in Grafana
  # """
  # def create_folder(_finch_process_name, _base_url, _bearer_token, _folder_id) do
  # end

  # @doc """
  # Used to fetch the details regarding a particular folder on Grafana
  # """
  # def get_folder(_finch_process_name, _base_url, _bearer_token, _folder_id) do
  # end

  defp grafana_headers(bearer_token) do
    [
      {"authorization", "Bearer #{bearer_token}"},
      {"content-type", "application/json"},
      {"accept", "application/json"}
    ]
  end

  defp generate_dashboard_payload(dashboard_definition) do
    dashboard = Jason.decode!(dashboard_definition)

    Map.new()
    |> Map.put(:overwrite, true)
    |> Map.put(:dashboard, dashboard)
    |> Jason.encode!()
  end
end
