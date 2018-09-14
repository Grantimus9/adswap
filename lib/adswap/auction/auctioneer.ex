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
      bids: [],
      auction_status: "waiting for bids"
    }

    schedule_tick()
    {:ok, state}
  end

  @impl true
  def handle_info(:tick, state) do
    # Do the desired work here
    case time_remaining(state) do
      x when x <= 0 ->
        AdswapWeb.Endpoint.broadcast("auction:lobby", "time_remaining", %{time: "AUCTION ENDED"})

      x ->
        AdswapWeb.Endpoint.broadcast("auction:lobby", "time_remaining", %{time: x})
    end

    schedule_tick()
    {:noreply, state}
  end

  defp schedule_tick() do
    Process.send_after(self(), :tick, 100) # every .1 seconds. We can go much faster actually.
  end

  defp time_remaining(state) do
    t = DateTime.utc_now() |> DateTime.to_unix()
    Map.get(state, :end_time) - t
  end

end
