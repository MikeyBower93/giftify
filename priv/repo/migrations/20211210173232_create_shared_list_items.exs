defmodule Giftify.Repo.Migrations.CreateSharedListItems do
  use Ecto.Migration

  def change do
    create table(:shared_list_items) do
      add :purchased, :boolean, default: false, null: false
      add :purchaser_id, references(:users, on_delete: :nothing)
      add :shared_list_id, references(:shared_list, on_delete: :nothing)
      add :gift_id, references(:gifts, on_delete: :nothing)

      timestamps()
    end

    create index(:shared_list_items, [:purchaser_id])
    create index(:shared_list_items, [:shared_list_id])
    create index(:shared_list_items, [:gift_id])
  end
end
