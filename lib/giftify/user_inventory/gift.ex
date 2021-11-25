defmodule Giftify.UserInventory.Gift do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gifts" do
    field :name, :string
    field :price, :decimal
    field :owner_id, :id

    timestamps()
  end

  @doc false
  def changeset(gift, attrs) do
    gift
    |> cast(attrs, [:name, :price, :owner_id])
    |> validate_required([:name, :price, :owner_id])
  end
end
