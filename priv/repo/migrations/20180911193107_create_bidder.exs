defmodule Adswap.Repo.Migrations.CreateBidder do
  use Ecto.Migration

  def change do


    create table(:campaigns) do
      add :name, :string, default: "Unknown Campaign"
      add :description, :string, default: "Brand Awareness"
      add :budget, :integer, default: 1000

      # the attributes that make an impression valuable to this campaign.
      # players don't know this.
      add :preferred_client_ip_addresses, {:array, :string}, default: []
      add :preferred_cookie_ids, {:array, :string}, default: []
      add :preferred_urls, {:array, :string}, default: []
      add :preferred_times, {:array, :string}, default: []


      timestamps()
    end

    create table(:bidders) do
      add :name, :string, default: "An Anonymous Bidder"
      add :code, :string, default: ""
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

    create table(:bids) do
      add :amount, :integer, default: 0
      add :bidder_id, references(:bidders)
      add :impression_id, references(:impressions)
      timestamps()
    end
    unique_index(:bids, [:impression_id, :bidder_id]) # only one bid per impression per bidder.

  end
end
