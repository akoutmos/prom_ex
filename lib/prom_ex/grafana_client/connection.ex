defmodule PromEx.GrafanaClient.Connection do
  @moduledoc """
  This struct encapsulates all of the data necessary
  to connect to a Grafana instance.
  """

  @type t :: %__MODULE__{
          finch_process: module(),
          base_url: String.t(),
          auth_token: String.t()
        }

  defstruct finch_process: nil, base_url: nil, auth_token: nil

  @doc """
  Build a connection struct for connecting to Grafana.
  """
  @spec build(finch_process :: module(), base_url :: String.t(), auth_token :: String.t()) :: __MODULE__.t()
  def build(finch_process, base_url, auth_token) do
    %__MODULE__{
      finch_process: finch_process,
      base_url: normalize_host(base_url),
      auth_token: "Bearer #{auth_token}"
    }
  end

  defp normalize_host(host_string) do
    host_string
    |> URI.parse()
    |> Map.put(:path, nil)
    |> Map.put(:query, nil)
    |> URI.to_string()
  end
end
