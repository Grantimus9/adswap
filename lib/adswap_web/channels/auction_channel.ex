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

  def handle_in("new_bid", bid, socket) do
    # Send Bid to Auction and handle response.
    case Auctioneer.bid(bid) do
      {:ok, bids} ->
        broadcast! socket, "auction_event", %{message: "Someone Bid"}
        broadcast! socket, "bid_count", %{count: Enum.count(bids)}
      _ ->
        nil
    end

    {:noreply, socket}
  end
end
