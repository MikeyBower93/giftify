defmodule Giftify.Sharing.SharedList do
  use Ecto.Schema
  import Ecto.Changeset

  alias Giftify.Accounts.User

  schema "shared_list" do
    field :active, :boolean, default: false
    field :name, :string
    field :owner_id, :id

    many_to_many :sharees, User, join_through: "shared_list_sharees", on_replace: :delete, join_keys: [shared_list_id: :id, sharee_id: :id]

    timestamps()
  end

  @doc false
  def changeset(shared_list, attrs) do
    shared_list
    |> cast(attrs, [:name, :active, :owner_id])
    |> validate_required([:name, :active, :owner_id])
  end
end
