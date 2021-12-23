defmodule Giftify.SharingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Giftify.Sharing` context.
  """

  @doc """
  Generate a shared_list.
  """
  def shared_list_fixture(attrs \\ %{}) do
    {:ok, shared_list} =
      attrs
      |> Enum.into(%{
        active: true,
        name: "some name",
        due: Date.utc_today()
      })
      |> Giftify.Sharing.create_shared_list()

    shared_list
  end
end
