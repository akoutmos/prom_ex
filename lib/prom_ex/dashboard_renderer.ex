defmodule PromEx.DashboardRenderer do
  @moduledoc """
  This module is used to read dashboard definitions, render EEx dashboards,
  and ensure that requested files actually exist
  """

  require Logger

  @type t :: %__MODULE__{
          file_type: :eex | :json | nil,
          relative_path: String.t(),
          assigns: keyword() | nil,
          file_contents: String.t(),
          rendered_file: String.t() | nil,
          decoded_dashboard: map() | nil,
          valid_json?: boolean() | nil,
          valid_file?: boolean(),
          error: tuple() | nil
        }

  defstruct [
    :file_type,
    :relative_path,
    :full_path,
    :otp_app,
    :assigns,
    :file_contents,
    :rendered_file,
    :decoded_dashboard,
    :valid_json?,
    :valid_file?,
    :error
  ]

  @doc """
  Read the contents of a dashboard file entry. If an EEx version of the file exists,
  read that, else fallback to the provided file name. For example, if the requested
  dashboard file is `ecto.json`, if `ecto.json.eex` exists, then that will be returned.
  This is more so for convenience so that you don't need to write out `.eex` everywhere
  given that all PromEx 1st party dashboards are EEx templates.
  """
  @spec build(dashboard_otp_app :: atom(), dashboard_relative_path :: String.t(), metrics_otp_app :: atom()) ::
          __MODULE__.t()
  def build(dashboard_otp_app, dashboard_relative_path, metrics_otp_app) do
    base_def = %__MODULE__{
      otp_app: dashboard_otp_app,
      relative_path: dashboard_relative_path,
      assigns: default_plugin_assigns(metrics_otp_app)
    }

    dashboard_full_path =
      dashboard_otp_app
      |> :code.priv_dir()
      |> :erlang.list_to_binary()
      |> Path.join(dashboard_relative_path)

    dashboard_full_path_eex = dashboard_full_path <> ".eex"

    cond do
      File.exists?(dashboard_full_path_eex) ->
        read_file(base_def, :eex, dashboard_full_path_eex)

      File.exists?(dashboard_full_path) and String.ends_with?(dashboard_full_path, ".eex") ->
        read_file(base_def, :eex, dashboard_full_path)

      File.exists?(dashboard_full_path) and String.ends_with?(dashboard_full_path, ".json") ->
        read_file(base_def, :json, dashboard_full_path)

      File.exists?(dashboard_full_path) ->
        %{base_def | valid_file?: false, error: {:file_read_error, :invalid_file_type}}

      true ->
        %{base_def | valid_file?: false, error: {:file_read_error, :file_not_found}}
    end
  end

  @doc """
  Renders the dashboard. If it is an EEx file then the PromEx module assigns are passed. Else
  if it is a raw json file then it is passed through untouched.
  """
  @spec render_dashboard(__MODULE__.t(), prom_ex_module :: module()) :: __MODULE__.t()
  def render_dashboard(%__MODULE__{valid_file?: false} = dashboard_render, _) do
    dashboard_render
  end

  def render_dashboard(%__MODULE__{file_type: :json} = dashboard_render, _) do
    %{dashboard_render | rendered_file: dashboard_render.file_contents}
  end

  def render_dashboard(%__MODULE__{assigns: assigns} = dashboard_render, prom_ex_module) do
    configured_title = Keyword.fetch!(assigns, :title)

    non_configurable_assigns = [
      uid:
        prom_ex_module.__grafana_dashboard_uid__(
          dashboard_render.otp_app,
          dashboard_render.relative_path,
          configured_title
        )
    ]

    %__MODULE__{file_type: :eex, assigns: assigns, file_contents: contents} =
      merge_assigns(dashboard_render, non_configurable_assigns)

    rendered_file = EEx.eval_string(contents, assigns: assigns)
    %{dashboard_render | rendered_file: rendered_file}
  end

  @doc """
  This function will decode the JSON dashboard using `Jason`. If any errors occur during the decoding process,
  the struct will be marked as having invalid JSON.
  """
  @spec decode_dashboard(__MODULE__.t()) :: __MODULE__.t()
  def decode_dashboard(%__MODULE__{valid_file?: false} = dashboard_render) do
    dashboard_render
  end

  def decode_dashboard(%__MODULE__{rendered_file: json_definition} = dashboard_render) do
    case Jason.decode(json_definition) do
      {:ok, decoded_dashboard} ->
        %{dashboard_render | decoded_dashboard: decoded_dashboard, valid_json?: true}

      {:error, reason} ->
        %{dashboard_render | error: {:json_decode, reason}, valid_json?: false}
    end
  end

  @doc """
  This function will execute a provided function on the rendered dashboard to give the user a chance to
  adjust the dashboard definition.
  """
  @spec apply_dashboard_function(__MODULE__.t(), (map() -> map())) :: __MODULE__.t()
  def apply_dashboard_function(%__MODULE__{valid_file?: false} = dashboard_render, _) do
    dashboard_render
  end

  def apply_dashboard_function(
        %__MODULE__{decoded_dashboard: decoded_dashboard} = dashboard_render,
        apply_function
      ) do
    updated_dashboard = apply_function.(decoded_dashboard)
    %{dashboard_render | decoded_dashboard: updated_dashboard}
  end

  @doc """
  This function will merge in the provided assigns to the struct's assigns. These assigns will
  then be used during the `render_dashboard/1` call to render any EEx template statements.
  """
  @spec merge_assigns(__MODULE__.t(), keyword()) :: __MODULE__.t()
  def merge_assigns(%__MODULE__{assigns: assigns} = dashboard_render, additional_assigns) do
    %{dashboard_render | assigns: Keyword.merge(assigns, additional_assigns)}
  end

  defp read_file(%__MODULE__{} = dashboard_render, type, path) do
    case File.read(path) do
      {:ok, contents} ->
        %{dashboard_render | file_type: type, full_path: path, file_contents: contents, valid_file?: true}

      {:error, reason} ->
        %{dashboard_render | valid_file?: false, full_path: path, error: {:file_read_error, reason}}
    end
  end

  defp default_plugin_assigns(otp_app) do
    [
      # View defaults
      default_selected_interval: "30s",

      # Metrics prefix defaults
      absinthe_metric_prefix: "#{otp_app}_prom_ex_absinthe",
      application_metric_prefix: "#{otp_app}_prom_ex_application",
      beam_metric_prefix: "#{otp_app}_prom_ex_beam",
      broadway_metric_prefix: "#{otp_app}_prom_ex_broadway",
      plug_cowboy_metric_prefix: "#{otp_app}_prom_ex_plug_cowboy",
      plug_router_metric_prefix: "#{otp_app}_prom_ex_plug_router",
      ecto_metric_prefix: "#{otp_app}_prom_ex_ecto",
      oban_metric_prefix: "#{otp_app}_prom_ex_oban",
      phoenix_metric_prefix: "#{otp_app}_prom_ex_phoenix",
      phoenix_live_view_metric_prefix: "#{otp_app}_prom_ex_phoenix_live_view",
      prom_ex_metric_prefix: "#{otp_app}_prom_ex_prom_ex"
    ]
  end
end
