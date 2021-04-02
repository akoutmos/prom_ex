defmodule PromEx.GrafanaClient.Connection do
  @moduledoc """
  This struct encapsulates all of the data necessary
  to connect to a Grafana instance.
  """

  @type t :: %__MODULE__{
          finch_process: module(),
          base_url: String.t(),
          authorization: String.t()
        }

  defstruct finch_process: nil, base_url: nil, authorization: nil

  @doc """
  Build a connection struct for connecting to Grafana.
  """
  @spec build(finch_process :: module(), grafana_config :: map()) :: __MODULE__.t()
  def build(finch_process, %{host: host, username: username, password: password, auth_token: nil}) do
    %__MODULE__{
      finch_process: finch_process,
      base_url: normalize_host(host),
      authorization: "Basic #{Base.encode64("#{username}:#{password}")}"
    }
  end

  def build(finch_process, %{host: host, auth_token: auth_token}) do
    %__MODULE__{
      finch_process: finch_process,
      base_url: normalize_host(host),
      authorization: "Bearer #{auth_token}"
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
