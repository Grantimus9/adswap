defmodule Adswap.Auction.Impression do
  use Ecto.Schema
  import Ecto.Changeset


  schema "impressions" do
    field :client_ip_address, :string
    field :cookie_id, :string
    field :time, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(impression, attrs) do
    impression
    |> cast(attrs, [:time, :url, :cookie_id, :client_ip_address])
    |> validate_required([:time, :url, :cookie_id, :client_ip_address])
  end
end
