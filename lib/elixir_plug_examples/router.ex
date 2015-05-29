defmodule ElixirPlugExamples.Router do
  use Plug.Router
  
  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  # Root path
  get "/" do
    send_resp(conn, 200, "This entire website runs on Elixir plugs!")
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
    send_resp(conn, 200, "#{name} is vital to our website's continued success.")
  end

  # Use an array of variables in the route
  get "/misc/*glob" do
    send_resp(conn, 200, "Woah there! Our website does not know what to do with this: #{inspect glob}")
  end

  # Send JSON response
  get "/json/:name" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{name: name}))
  end

  # Send request to module
  get "/dynamic/:name" do
    ElixirPlugExamples.Dynamic.render(conn, name)
  end

  # 404 Fallback
  match _ do
    send_resp(conn, 404, "You did something terribly wrong...")
  end
end