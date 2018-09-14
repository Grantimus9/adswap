defmodule AdswapWeb.AuctionChannel do
  use Phoenix.Channel
  alias Adswap.Auction.Auctioneer

  def join("auction:lobby", _message, socket) do
    Process.send_after(Auctioneer, :tick, 1)
    {:ok, socket}
  end

  def join("auction:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_bid", %{"bidAmount" => bid_amount, "bidCode" => bidder_code}, socket) do
    #

    broadcast! socket, "new_bid", %{bid: bid_amount}
    {:noreply, socket}
  end
end
