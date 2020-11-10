defmodule PromEx.GrafanaClient.DashboardChecker do
  @moduledoc """
  This module is used to validate Grafana dashboard to ensure that
  they adhere to certain style and structure requirements.
  """

  # TODO: Items to check for to ensure uniformity
  # - Shared cross hair
  # - YAxis min 0 on non-negative data
  # - Y axis labels
  # - Ensure null ID field value
  # - Ensure readonly dashboard
  # - Ensure uid is prefixed with "prom_ex_"
  # - Ensure version is always at 1
  # - Ensure timeline is current time - 1h
  # - Ensure refresh interval is 5s
end
