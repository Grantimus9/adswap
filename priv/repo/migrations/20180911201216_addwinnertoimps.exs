defmodule Adswap.Repo.Migrations.Addwinnertoimps do
  use Ecto.Migration

  def change do
    alter table(:impressions) do
      add :winning_campaign_id, references(:campaigns)
    end
    unique_index(:impressions, :winning_campaign_id)
  end
end
