defmodule Adswap.Repo.Migrations.Addclickedtoimpressions do
  use Ecto.Migration

  def change do
    alter table(:impressions) do
      add :clicked, :boolean, default: false
    end
  end
end
