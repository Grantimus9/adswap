defmodule Adswap.Auction.Campaign do
  use Ecto.Schema
  import Ecto.Changeset


  schema "campaigns" do
    field :budget, :integer
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:name, :description, :budget])
    |> validate_required([:name, :description, :budget])
  end
end
