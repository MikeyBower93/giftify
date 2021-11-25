defmodule Giftify.UserInventoryTest do
  use Giftify.DataCase

  alias Giftify.UserInventory

  describe "gifts" do
    alias Giftify.UserInventory.Gift

    import Giftify.UserInventoryFixtures

    @invalid_attrs %{name: nil, price: nil}

    # test "list_gifts/0 returns all gifts" do
    #   gift = gift_fixture()
    #   assert UserInventory.list_gifts() == [gift]
    # end

    # test "get_gift!/1 returns the gift with given id" do
    #   gift = gift_fixture()
    #   assert UserInventory.get_gift!(gift.id) == gift
    # end

    # test "create_gift/1 with valid data creates a gift" do
    #   valid_attrs = %{name: "some name", price: "120.5"}

    #   assert {:ok, %Gift{} = gift} = UserInventory.create_gift(valid_attrs)
    #   assert gift.name == "some name"
    #   assert gift.price == Decimal.new("120.5")
    # end

    # test "create_gift/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = UserInventory.create_gift(@invalid_attrs)
    # end

    # test "update_gift/2 with valid data updates the gift" do
    #   gift = gift_fixture()
    #   update_attrs = %{name: "some updated name", price: "456.7"}

    #   assert {:ok, %Gift{} = gift} = UserInventory.update_gift(gift, update_attrs)
    #   assert gift.name == "some updated name"
    #   assert gift.price == Decimal.new("456.7")
    # end

    # test "update_gift/2 with invalid data returns error changeset" do
    #   gift = gift_fixture()
    #   assert {:error, %Ecto.Changeset{}} = UserInventory.update_gift(gift, @invalid_attrs)
    #   assert gift == UserInventory.get_gift!(gift.id)
    # end

    # test "delete_gift/1 deletes the gift" do
    #   gift = gift_fixture()
    #   assert {:ok, %Gift{}} = UserInventory.delete_gift(gift)
    #   assert_raise Ecto.NoResultsError, fn -> UserInventory.get_gift!(gift.id) end
    # end

    # test "change_gift/1 returns a gift changeset" do
    #   gift = gift_fixture()
    #   assert %Ecto.Changeset{} = UserInventory.change_gift(gift)
    # end
  end
end
