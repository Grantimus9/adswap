defmodule Adswap.Repo.Migrations.CreateCampaigns do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :name, :string, default: "Unknown Campaign"
      add :description, :string, default: "Brand Awareness"
      add :budget, :integer, default: 1000

      timestamps()
    end
  end
end
