defmodule PromEx.MetricsServer.Plug do
  @moduledoc """
  This plug is used to serve metrics when PromEx is run in a
  standalone server configuration. This plug supports the
  following options:

  * `:path` - The route that should expose the metrics (default is "/metrics")
  * `:prom_ex_module` - The PromEx module that this plug will expose
  """

  @behaviour Plug

  require Logger

  import Plug.Conn

  alias Plug.Conn

  @impl true
  def init(opts) do
    Map.pop(opts, :auth_strategy, :none)
  end

  @impl true
  def call(%Conn{request_path: path} = conn, {:none, %{path: path, prom_ex_module: prom_ex_module}}) do
    case PromEx.get_metrics(prom_ex_module) do
      :prom_ex_down ->
        Logger.warn("Attempted to fetch metrics from #{prom_ex_module}, but the module has not been initialized")

        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(503, "Service Unavailable")

      metrics ->
        PromEx.ETSCronFlusher.defer_ets_flush(prom_ex_module.__ets_cron_flusher_name__())

        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(200, metrics)
    end
  end

  def call(
        %Conn{request_path: path} = conn,
        {:bearer, %{auth_token: auth_token, path: path} = plug_opts}
      ) do
    with ["Bearer " <> req_auth_token] <- get_req_header(conn, "authorization"),
         true <- req_auth_token == auth_token do
      call(conn, {:none, plug_opts})
    else
      _ ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(401, "Unauthorized")
    end
  end

  def call(
        %Conn{request_path: path} = conn,
        {:basic, %{auth_user: auth_user, auth_password: auth_password, path: path} = plug_opts}
      ) do
    with ["Basic " <> req_auth_user_pass] <- get_req_header(conn, "authorization"),
         {:ok, user_and_pass} <- Base.decode64(req_auth_user_pass),
         [req_user, req_pass] <- String.split(user_and_pass, ":", parts: 2),
         true <- req_user == auth_user,
         true <- req_pass == auth_password do
      call(conn, {:none, plug_opts})
    else
      _ ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(401, "Unauthorized")
    end
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(404, "Not Found")
  end
end
