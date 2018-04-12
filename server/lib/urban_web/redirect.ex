defmodule UrbanWeb.Redictor do
  @server_path "api"

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    if List.first(conn.path_info) == @server_path do
      conn
    else
      conn
      |> Plug.Conn.put_resp_header("location", "/")
    end
  end
end
