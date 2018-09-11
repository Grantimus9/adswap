defmodule Adswap.Auction.Campaign do
  use Ecto.Schema
  import Ecto.Changeset
  alias Adswap.Auction.Bidder

  schema "campaigns" do
    field :budget, :integer
    field :description, :string
    field :name, :string

    field :preferred_client_ip_addresses, {:array, :string}, default: []
    field :preferred_cookie_ids, {:array, :string}, default: []
    field :preferred_urls, {:array, :string}, default: []
    field :preferred_times, {:array, :string}, default: []

    has_many :bidders, Bidder

    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:name, :description, :budget])
    |> validate_required([:name, :description, :budget])
  end
end
