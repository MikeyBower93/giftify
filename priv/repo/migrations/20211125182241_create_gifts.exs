defmodule Giftify.Repo.Migrations.CreateGifts do
  use Ecto.Migration

  def change do
    create table(:gifts) do
      add :name, :string
      add :price, :decimal
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:gifts, [:owner_id])
  end
end
