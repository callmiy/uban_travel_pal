defmodule UrbanWeb.Redictor do
  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    if List.first(conn.path_info) == "api" do
      conn
    else
      conn
      |> Plug.Conn.put_resp_header("location", "/")
    end
  end
end
