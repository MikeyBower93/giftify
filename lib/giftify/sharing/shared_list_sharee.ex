defmodule Giftify.Sharing.SharedListSharee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shared_list_sharees" do
    field :sharee_id, :id
    field :shared_list_id, :id

    timestamps()
  end

  @doc false
  def changeset(shared_list_sharee, attrs) do
    shared_list_sharee
    |> cast(attrs, [:sharee_id, :shared_list_id])
    |> validate_required([:sharee_id, :shared_list_id])
  end
end
