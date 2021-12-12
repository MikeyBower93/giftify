defmodule Giftify.Repo.Migrations.CreateSharedListSharees do
  use Ecto.Migration

  def change do
    create table(:shared_list_sharees) do
      add :sharee_id, references(:users, on_delete: :nothing)
      add :shared_list_id, references(:shared_list, on_delete: :nothing)

      timestamps()
    end

    create index(:shared_list_sharees, [:sharee_id])
    create index(:shared_list_sharees, [:shared_list_id])
  end
end
