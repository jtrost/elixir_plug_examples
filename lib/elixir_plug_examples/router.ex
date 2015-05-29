defmodule ElixirPlugExamples.Router do
  use Plug.Router
  
  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  # Root path
  get "/" do
    conn
    |> Plug.Conn.send_resp(200, "This entire website runs on Elixir plugs!")
  end

  # Using match
  match "/about/contact", via: :get do
    send_resp(conn, 200, "You cannot contact us, so please stop trying.")
  end

  # Use match with a guard clause
  match "/about/:name" when name == "history", via: :get do
    send_resp(conn, 200, "Our website has a short, yet colorful history.")
  end

  # Use a variable in the route
  get "/about/:name" do
    conn
    |> Plug.Conn.send_resp(200, "#{name} is vital to our website's continued success.")
  end

  # Use an array of variables in the route
  get "/misc/*glob" do
    send_resp(conn, 200, "Woah there! Our website does not know what to do with this: #{inspect glob}")
  end

  # 404 Fallback
  get "/*glob" do
    send_resp(conn, 404, "You did something terribly wrong...")
  end
end