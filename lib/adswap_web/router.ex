defmodule AdswapWeb.Router do
  use AdswapWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdswapWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/bidders", BidderController
    resources "/impressions", ImpressionController, only: [:show, :index]
    resources "/campaigns", CampaignController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AdswapWeb do
  #   pipe_through :api
  # end
end
