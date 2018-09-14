defmodule Adswap.Auction.Bidder do
  use Ecto.Schema
  import Ecto.Changeset
  alias Adswap.Auction.Campaign

  schema "bidders" do
    field :name, :string, default: "An Anonymous Bidder"
    field :code, :string, default: ""

    belongs_to :campaign, Campaign

    timestamps()
  end

  @doc false
  def changeset(bidder, attrs) do
    bidder
    |> cast(attrs, [:name, :campaign_id, :code])
    |> validate_required([:name])
    |> validate_length(:code, min: 2, max: 4)
  end


end
