defmodule PhoenixStarterWeb.Router do
  use PhoenixStarterWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :fetch_session
    plug :accepts, ["json"]
  end

  pipeline :logged_in do
    plug PhoenixStarterWeb.Auth.Pipeline
  end

  pipeline :admin do
    plug PhoenixStarterWeb.Auth.AdminPipeline
  end

  scope "/admin" do
    pipe_through [:browser, :admin]

    live_dashboard "/analytics", metrics: PhoenixStarterWeb.Telemetry
  end

  scope "/api", PhoenixStarterWeb do
    pipe_through :api

    get "/example", ExampleController, :index
    resources "/user", UserController, only: [:create]
    resources "/sessions", SessionController, only: [:create]
  end

  scope "/api", PhoenixStarterWeb do
    pipe_through [:api, :logged_in]

    resources "/user", UserController,
      only: [:show, :update, :delete],
      singleton: true

    resources "/sessions", SessionController, only: [:delete], singleton: true
  end

  scope "/", PhoenixStarterWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
