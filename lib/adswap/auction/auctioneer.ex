defmodule Adswap.Auction.Auctioneer do
  @moduledoc """
    Genserver that orchestrates running an auction.
  """
  use GenServer
  alias Adswap.Auction.ImpressionGenerator
  alias Adswap.Auction

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def start_new_auction() do
    GenServer.call(__MODULE__, :start_new)
  end

  # Recieves a bid.
  # Either returns {:ok, bids} or {:error, "message"}
  # e.g. {:error, "Auction ended"}
  # e.g. {:error, "Already bid"}
  def bid(bid) do
    GenServer.call(__MODULE__, {:bid, bid})
  end

  @impl true
  def init(state) do
    state = new_auction_state()
    schedule_tick()
    {:ok, state}
  end

  # Receive a bid. Add it to the list of bids only if the
  # bidder_code hasn't already bid.
  def handle_call({:bid, new_bid}, _from, state) do
    new_bid = %{
      bidder_code: Map.get(new_bid, "bidder_code"),
      bid_amount: String.to_integer(Map.get(new_bid, "bid_amount"))
    }

    state =
      state
      |> Map.get(:bids)
      |> Enum.filter(fn(bid) -> bid.bidder_code == new_bid.bidder_code end)
      |> Enum.any?()
      |> case do
        true ->
          state
        false ->
          state
          |> Map.put(:bids, [new_bid | Map.get(state, :bids)])
      end

    IO.inspect state

    {:reply, {:ok, Map.get(state, :bids)}, state}
  end

  def handle_call(:start_new, _from, _state) do
    state = new_auction_state()
    schedule_tick()
    {:reply, :ok, state}
  end

  @impl true
  def handle_info(:tick, state) do
    # Do the desired work here
    state =
      state
      |> set_time_remaining()
      |> set_auction_status()

    impression =
      state
      |> Map.get(:impression)
      |> Map.take([:client_ip_address, :cookie_id, :time, :url])

    AdswapWeb.Endpoint.broadcast("auction:lobby", "time_remaining", %{time: Map.get(state, :time_remaining)})
    AdswapWeb.Endpoint.broadcast("auction:lobby", "auction_status", %{auction_status: Map.get(state, :auction_status)})
    AdswapWeb.Endpoint.broadcast("auction:lobby", "impression", %{impression: impression})

    case Map.get(state, :time_remaining) do
      0 ->
        # If auction is over need to start settlement process.
        # Choose winner, calculate winning bid, and winning price paid.
        results = Auction.choose_winner(Map.get(state, :bids))

        # Log Impression, Bill campaign
        Auction.settle_auction(impression, %{winner_code: results.winner_code, winner_pays: results.winner_pays})

        # broadcast winner information to participants
        AdswapWeb.Endpoint.broadcast("auction:lobby", "auction_event", %{message: "Bidding Closed."})
        AdswapWeb.Endpoint.broadcast("auction:lobby", "auction_event", %{message: "Winning Bidder Paid: " <> Integer.to_string(Map.get(results, :winner_pays))})

        nil

      _ ->
       schedule_tick()
    end

    {:noreply, state}
  end

  defp schedule_tick() do
    Process.send_after(self(), :tick, 100) # every .1 seconds. We can go much faster actually.
  end

  defp time_remaining(state) do
    t = DateTime.utc_now() |> DateTime.to_unix()
    case Map.get(state, :end_time) - t do
      x when x <= 0 ->
        0
      x ->
        x
    end
  end

  defp set_time_remaining(state) do
    %{state | time_remaining: time_remaining(state)}
  end

  defp set_auction_status(state) do
    status =
      case Map.get(state, :time_remaining) do
        x when x <= 0 ->
          "Ended"
        _ ->
          "Waiting For Bids"
      end

    state = %{state | auction_status: status}
  end

  defp new_auction_state() do
    [imp] = ImpressionGenerator.generate(1)
    now = DateTime.utc_now() |> DateTime.to_unix()
    end_time = now + 15

    state = %{
      impression: imp,
      end_time: end_time,
      time_remaining: 500,
      bids: [%{bid_amount: 0, bidder_code: "Default"}],
      auction_status: "waiting for bids"
    }
  end

end
