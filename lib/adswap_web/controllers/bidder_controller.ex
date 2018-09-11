defmodule AdswapWeb.BidderController do
  use AdswapWeb, :controller

  alias Adswap.Auction
  alias Adswap.Auction.Bidder

  def index(conn, _params) do
    bidders = Auction.list_bidders()
    render(conn, "index.html", bidders: bidders)
  end

  def new(conn, _params) do
    changeset = Auction.change_bidder(%Bidder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bidder" => bidder_params}) do
    case Auction.create_bidder(bidder_params) do
      {:ok, bidder} ->
        conn
        |> put_flash(:info, "Bidder created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bidder = Auction.get_bidder!(id)
    render(conn, "show.html", bidder: bidder)
  end

  def edit(conn, %{"id" => id}) do
    bidder = Auction.get_bidder!(id)
    changeset = Auction.change_bidder(bidder)
    render(conn, "edit.html", bidder: bidder, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bidder" => bidder_params}) do
    bidder = Auction.get_bidder!(id)

    case Auction.update_bidder(bidder, bidder_params) do
      {:ok, bidder} ->
        conn
        |> put_flash(:info, "Bidder updated successfully.")
        |> redirect(to: bidder_path(conn, :show, bidder))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bidder: bidder, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bidder = Auction.get_bidder!(id)
    {:ok, _bidder} = Auction.delete_bidder(bidder)

    conn
    |> put_flash(:info, "Bidder deleted successfully.")
    |> redirect(to: bidder_path(conn, :index))
  end
end
