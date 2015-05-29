defmodule ElixirPlugExamples.Dynamic do
  import Plug.Conn

  def render(conn, name) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello #{name}, this was rendered in a module.")
  end
end