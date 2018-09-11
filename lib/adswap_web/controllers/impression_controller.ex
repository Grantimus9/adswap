defmodule AdswapWeb.ImpressionController do
  use AdswapWeb, :controller

  alias Adswap.Auction
  alias Adswap.Auction.Impression

  def index(conn, _params) do
    impressions = Auction.list_impressions()
    render(conn, "index.html", impressions: impressions)
  end

  def new(conn, _params) do
    changeset = Auction.change_impression(%Impression{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"impression" => impression_params}) do
    case Auction.create_impression(impression_params) do
      {:ok, impression} ->
        conn
        |> put_flash(:info, "Impression created successfully.")
        |> redirect(to: impression_path(conn, :show, impression))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    impression = Auction.get_impression!(id)
    render(conn, "show.html", impression: impression)
  end

  def edit(conn, %{"id" => id}) do
    impression = Auction.get_impression!(id)
    changeset = Auction.change_impression(impression)
    render(conn, "edit.html", impression: impression, changeset: changeset)
  end

  def update(conn, %{"id" => id, "impression" => impression_params}) do
    impression = Auction.get_impression!(id)

    case Auction.update_impression(impression, impression_params) do
      {:ok, impression} ->
        conn
        |> put_flash(:info, "Impression updated successfully.")
        |> redirect(to: impression_path(conn, :show, impression))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", impression: impression, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    impression = Auction.get_impression!(id)
    {:ok, _impression} = Auction.delete_impression(impression)

    conn
    |> put_flash(:info, "Impression deleted successfully.")
    |> redirect(to: impression_path(conn, :index))
  end
end
