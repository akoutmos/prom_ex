defmodule PromEx.GrafanaClient do
  @moduledoc """
  This module is used by the Mix tasks that are available in PromEx to update
  dashboards in Grafana and also by the `PromEx.DashboardUpdater` to update
  dashboards automatically on application initialization.
  """

  require Logger

  def create_or_update_dashboard(finch_process_name, base_url, bearer_token, dashboard_file_path) do
    case File.read(dashboard_file_path) do
      {:ok, dashboard_contents} ->
        headers = [
          authorization: "Bearer #{bearer_token}",
          "content-type": "application/json",
          accept: "application/json"
        ]

        :post
        |> Finch.build("#{base_url}/api/dashboard/db", headers, dashboard_contents)
        |> Finch.request(finch_process_name)
        |> IO.inspect(label: "Grafana response")

        :ok

      {:error, reason} ->
        Logger.warn("Failed to read file #{dashboard_file_path} because of reason: #{inspect(reason)}")
        {:error, :invalid_dashboard}
    end
  end

  def create_folder(finch_process_name, base_url, bearer_token, folder_id) do
  end

  def get_folder(finch_process_name, base_url, bearer_token, folder_id) do
  end
end
