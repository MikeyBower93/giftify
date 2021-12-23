defmodule Giftify.Sharing.SharedList do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Giftify.Accounts.User

  schema "shared_list" do
    field :active, :boolean, default: false
    field :name, :string
    field :due, :date
    field :owner_id, :id

    many_to_many :sharees, User,
      join_through: "shared_list_sharees",
      on_replace: :delete,
      join_keys: [shared_list_id: :id, sharee_id: :id]

    timestamps()
  end

  @doc false
  def changeset(shared_list, attrs) do
    shared_list
    |> cast(attrs, [:name, :due, :owner_id, :active])
    |> validate_required([:name, :due, :owner_id])
    |> validate_change(:due, fn :due, due ->
      if Date.compare(due, Date.utc_today()) == :lt do
        [due: "Must be after today"]
      else
        []
      end
    end)
  end
end
