defmodule Adswap.Auction do
  @moduledoc """
  The Auction context.
  """

  import Ecto.Query, warn: false
  alias Adswap.Repo

  alias Adswap.Auction.Bidder

  @doc """
  Returns the list of bidders.

  ## Examples

      iex> list_bidders()
      [%Bidder{}, ...]

  """
  def list_bidders do
    Repo.all(Bidder)
  end

  @doc """
  Gets a single bidder.

  Raises `Ecto.NoResultsError` if the Bidder does not exist.

  ## Examples

      iex> get_bidder!(123)
      %Bidder{}

      iex> get_bidder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bidder!(id), do: Repo.get!(Bidder, id)

  @doc """
  Creates a bidder.

  ## Examples

      iex> create_bidder(%{field: value})
      {:ok, %Bidder{}}

      iex> create_bidder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bidder(attrs \\ %{}) do
    %Bidder{}
    |> Bidder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bidder.

  ## Examples

      iex> update_bidder(bidder, %{field: new_value})
      {:ok, %Bidder{}}

      iex> update_bidder(bidder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bidder(%Bidder{} = bidder, attrs) do
    bidder
    |> Bidder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Bidder.

  ## Examples

      iex> delete_bidder(bidder)
      {:ok, %Bidder{}}

      iex> delete_bidder(bidder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bidder(%Bidder{} = bidder) do
    Repo.delete(bidder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bidder changes.

  ## Examples

      iex> change_bidder(bidder)
      %Ecto.Changeset{source: %Bidder{}}

  """
  def change_bidder(%Bidder{} = bidder) do
    Bidder.changeset(bidder, %{})
  end
end
