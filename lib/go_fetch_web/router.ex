defmodule GoFetchWeb.Router do
  use GoFetchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  # coveralls-ignore-start
  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: GoFetchWeb.Schema)

    forward "/", Absinthe.Plug, schema: GoFetchWeb.Schema, log_level: :info
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: GoFetchWeb.Telemetry
    end
  end

  # coveralls-ignore-stop

  scope "/", GoFetchWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
end
