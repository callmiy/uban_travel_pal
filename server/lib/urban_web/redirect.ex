defmodule UrbanWeb.Redictor do
  @served_path ~w(api plan-assets)

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    [path_info | _] = conn.path_info

    if Enum.member?(@served_path, path_info) do
      conn
    else
      conn
      |> Plug.Conn.put_resp_header("location", "/")
    end
  end
end
