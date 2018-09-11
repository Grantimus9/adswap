defmodule Adswap.Repo.Migrations.CreateImpressions do
  use Ecto.Migration

  def change do
    create table(:impressions) do
      add :time, :string, default: "unknown"
      add :url, :string, default: "unknown"
      add :cookie_id, :string, default: "-1"
      add :client_ip_address, :string, default: "127.0.0.1"

      timestamps()
    end

  end
end
