defmodule AdswapWeb.PageController do
  use AdswapWeb, :controller
  alias Adswap.Auction

  def index(conn, _params) do
    render conn, "index.html"
  end

  def display(conn, _params) do
    bidders = Auction.list_bidders()

    render conn, "display.html", bidders: bidders
  end
end
