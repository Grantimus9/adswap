defmodule Adswap.Auction.Impression do
  use Ecto.Schema
  import Ecto.Changeset
  alias Adswap.Auction.Campaign


  schema "impressions" do
    field :client_ip_address, :string
    field :cookie_id, :string
    field :time, :string
    field :url, :string
    field :clicked, :boolean, default: false

    belongs_to :campaign, Campaign, [foreign_key: :winning_campaign_id]

    timestamps()
  end

  @doc false
  def changeset(impression, attrs) do
    impression
    |> cast(attrs, [:time, :url, :cookie_id, :client_ip_address, :clicked, :winning_campaign_id])
    |> validate_required([:time, :url, :cookie_id, :client_ip_address])
  end
end
