defmodule Giftify.Repo.Migrations.CreateSharedList do
  use Ecto.Migration

  def change do
    create table(:shared_list) do
      add :name, :string
      add :active, :boolean, default: false, null: false
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:shared_list, [:owner_id])
  end
end
