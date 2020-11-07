defmodule PromEx.GrafanaClient.Connection do
  @moduledoc """
  This struct encapsulates all of the data necessary
  to connect to a grafana instance.
  """

  @type t :: %__MODULE__{
          finch_process: atom(),
          base_url: String.t(),
          auth_token: String.t()
        }

  defstruct finch_process: nil, base_url: nil, auth_token: nil

  @doc """
  Build a connection struct for connecting to Grafana.
  """
  @spec build(finch_process :: String.t(), base_url :: String.t(), auth_token :: String.t()) :: __MODULE__.t()
  def build(finch_process, base_url, auth_token) do
    %__MODULE__{
      finch_process: finch_process,
      base_url: base_url,
      auth_token: "Bearer #{auth_token}"
    }
  end
end
