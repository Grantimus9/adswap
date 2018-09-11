defmodule Adswap.Repo.Migrations.CreateBidder do
  use Ecto.Migration

  def change do


    create table(:campaigns) do
      add :name, :string, default: "Unknown Campaign"
      add :description, :string, default: "Brand Awareness"
      add :budget, :integer, default: 1000

      timestamps()
    end

    create table(:bidders) do
      add :name, :string, default: "An Anonymous Bidder"
      add :campaign_id, references(:campaigns)
      timestamps()
    end

    unique_index(:bidders, :campaign_id)


    create table(:impressions) do
      add :time, :string, default: "unknown"
      add :url, :string, default: "unknown"
      add :cookie_id, :string, default: "-1"
      add :client_ip_address, :string, default: "127.0.0.1"
      add :winning_campaign_id, references(:campaigns)
      timestamps()
    end

    unique_index(:impressions, :winning_campaign_id)

  end
end
