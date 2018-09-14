defmodule Adswap.Auction.Auctioneer do
  @moduledoc """
    Genserver that orchestrates running an auction.
  """
  use GenServer
  alias Adswap.Auction.ImpressionGenerator

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    [imp] = ImpressionGenerator.generate(1)
    now = DateTime.utc_now() |> DateTime.to_unix()
    end_time = now + 15

    state = %{
      impression: imp,
      end_time: end_time,
      time_remaining: 500,
      bids: [],
      auction_status: "waiting for bids"
    }

    schedule_tick()
    {:ok, state}
  end

  @impl true
  def handle_info(:tick, state) do
    # Do the desired work here
    state =
      state
      |> set_time_remaining()
      |> set_auction_status()

    AdswapWeb.Endpoint.broadcast("auction:lobby", "time_remaining", %{time: Map.get(state, :time_remaining)})
    AdswapWeb.Endpoint.broadcast("auction:lobby", "auction_status", %{auction_status: Map.get(state, :auction_status)})

    case Map.get(state, :time_remaining) do
      0 ->
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

end
