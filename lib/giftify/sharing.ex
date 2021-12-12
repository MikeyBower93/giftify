defmodule Giftify.Sharing do
  @moduledoc """
  The Sharing context.
  """

  import Ecto.Query, warn: false
  alias Giftify.Repo

  alias Giftify.Sharing.{SharedList, SharedListSharee}

  def my_lists(owner_id) do
    Repo.all(from list in SharedList, where: list.owner_id == ^owner_id)
  end

  def other_lists(sharee_id) do
    Repo.all(
      from list in SharedList,
        join: sharees in assoc(list, :sharees),
        where: sharees.id == ^sharee_id
    )
  end

  def share_list(%SharedList{} = to_share, sharee_id) do
    %SharedListSharee{}
    |> SharedListSharee.changeset(%{sharee_id: sharee_id, shared_list_id: to_share.id})
    |> Repo.insert!()
  end

  @doc """
  Creates a shared_list.

  ## Examples

      iex> create_shared_list(%{field: value})
      {:ok, %SharedList{}}

      iex> create_shared_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shared_list(attrs \\ %{}) do
    %SharedList{}
    |> SharedList.changeset(attrs)
    |> Repo.insert()
  end
end
