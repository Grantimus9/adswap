defmodule AdswapWeb.ControlController do
  use AdswapWeb, :controller
  @moduledoc """
    For the admins/Organizers.
  """
  alias Adswap.Auction
  alias Adswap.Auction.Auctioneer

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new_auction(conn, _params) do
    Auctioneer.start_new_auction()

    conn
    |> put_flash(:info, "Started New Auction")
    |> render("index.html")
  end

end
