defmodule Adswap.Repo.Migrations.CreateBidder do
  use Ecto.Migration

  def change do
    create table(:bidders) do
      add :name, :string, default: "An Anonymous Bidder"
      add :balance, :integer, default: 1000
      timestamps()
    end
  end
end
