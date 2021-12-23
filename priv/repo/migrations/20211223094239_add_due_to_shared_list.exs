defmodule Giftify.Repo.Migrations.AddDueToSharedList do
  use Ecto.Migration

  def change do
    alter table(:shared_list) do
      add :due, :date
    end
  end
end
