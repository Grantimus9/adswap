defmodule Adswap.Auction.Campaign do
  use Ecto.Schema
  import Ecto.Changeset
  alias Adswap.Auction.Bidder

  schema "campaigns" do
    field :budget, :integer
    field :description, :string
    field :name, :string
    belongs_to :bidder, Bidder
    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:name, :description, :budget])
    |> validate_required([:name, :description, :budget])
  end
end
