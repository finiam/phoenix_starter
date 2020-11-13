defmodule PhoenixStarterWeb.Router do
  use PhoenixStarterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"

    plug :accepts, ["json"]
  end

  scope "/api", PhoenixStarterWeb do
    pipe_through :api

    get "/example", ExampleController, :index
  end

  scope "/", PhoenixStarterWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
