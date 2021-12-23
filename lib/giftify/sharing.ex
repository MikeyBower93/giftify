defmodule Giftify.Sharing do
  @moduledoc """
  The Sharing context.
  """

  import Ecto.Query, warn: false
  alias Giftify.Repo

  alias Giftify.Sharing.{SharedList, SharedListSharee}

  def get_list(id, preloads \\ nil) do
    query = from list in SharedList, where: list.id == ^id

    query =
      if is_nil(preloads) do
        query
      else
        preload(query, ^preloads)
      end

    Repo.one(query)
  end

  def my_lists(owner_id) do
    Repo.all(from list in SharedList, where: list.owner_id == ^owner_id)
  end

  def other_lists(sharee_id) do
    Repo.all(
      from list in SharedList,
        join: sharees in assoc(list, :sharees),
        where: sharees.id == ^sharee_id and list.active == ^true
    )
  end

  def share_list(%SharedList{} = to_share, sharee_id) do
    if to_share.owner_id == sharee_id do
      {:error, :cannot_add_self}
    else
      %SharedListSharee{}
      |> SharedListSharee.changeset(%{sharee_id: sharee_id, shared_list_id: to_share.id})
      |> Repo.insert!()
    end
  end

  def remove_sharee_from_list(sharee_id, %SharedList{} = shared_list) do
    Repo.delete_all(
      from sharee in SharedListSharee,
        where: sharee.shared_list_id == ^shared_list.id and sharee.sharee_id == ^sharee_id
    )
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

  def change_shared_list(shared_list, attrs \\ %{}) do
    SharedList.changeset(shared_list, attrs)
  end
end
