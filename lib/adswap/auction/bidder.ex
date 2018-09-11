defmodule Adswap.Auction.Bidder do
  use Ecto.Schema
  import Ecto.Changeset
  alias Adswap.Auction.Campaign

  schema "bidders" do
    field :name, :string, default: "An Anonymous Bidder"
    belongs_to :campaign, Campaign

    timestamps()
  end

  @doc false
  def changeset(bidder, attrs) do
    bidder
    |> cast(attrs, [:name, :campaign_id])
    |> validate_required([:name])
  end


end
