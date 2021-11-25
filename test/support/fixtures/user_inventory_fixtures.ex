defmodule Giftify.UserInventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Giftify.UserInventory` context.
  """

  @doc """
  Generate a gift.
  """
  def gift_fixture(attrs \\ %{}) do
    {:ok, gift} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: "120.5"
      })
      |> Giftify.UserInventory.create_gift()

    gift
  end
end
