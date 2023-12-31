defmodule ElixirFizzBuzzWeb.Router do
  use ElixirFizzBuzzWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ElixirFizzBuzzWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirFizzBuzzWeb do
    pipe_through :api
    get "/get_values_between", FizzBuzzController, :get_values_between
    get "/get_homepage_values", FizzBuzzController, :get_homepage_values
    get "/get_favourites", FizzBuzzController, :get_favourites
    post "/set_favourite", FizzBuzzController, :set_favourite
    delete "/delete_favourite", FizzBuzzController, :delete_favourite
  end

  scope "/", ElixirFizzBuzzWeb do
    pipe_through :browser
    live "/", FizzBuzzLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirFizzBuzzWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:elixir_fizz_buzz, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ElixirFizzBuzzWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
