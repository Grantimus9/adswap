defmodule Adswap.Auction.Bidder do
  use Ecto.Schema
  import Ecto.Changeset


  schema "bidders" do
    field :balance, :integer, default: 1000
    field :name, :string, default: "An Anonymous Bidder"
    timestamps()
  end

  @doc false
  def changeset(bidder, attrs) do
    bidder
    |> cast(attrs, [:name, :balance])
    |> validate_required([:name, :balance])
  end
end
