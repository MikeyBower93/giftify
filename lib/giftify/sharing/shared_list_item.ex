defmodule Giftify.Sharing.SharedListItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shared_list_items" do
    field :purchased, :boolean, default: false
    field :purchaser_id, :id
    field :shared_list_id, :id
    field :gift_id, :id

    timestamps()
  end

  @doc false
  def changeset(shared_list_item, attrs) do
    shared_list_item
    |> cast(attrs, [:purchased])
    |> validate_required([:purchased])
  end
end
