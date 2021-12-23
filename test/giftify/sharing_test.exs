defmodule Giftify.SharingTest do
  use Giftify.DataCase

  alias Giftify.Sharing

  describe "shared_list" do
    import Giftify.SharingFixtures
    import Giftify.AccountsFixtures

    test "my_lists/1 returns only my lists" do
      me = user_fixture()
      other_person = user_fixture()

      my_list = shared_list_fixture(owner_id: me.id)
      shared_list_fixture(owner_id: other_person.id)

      assert Sharing.my_lists(me.id) == [my_list]
    end

    test "other_lists/1 returns other persons lists shared with me" do
      me = user_fixture()
      other_person = user_fixture()

      shared_list_fixture(owner_id: me.id)
      shared_list_fixture(owner_id: other_person.id)
      other_persons_list_shared = shared_list_fixture(owner_id: other_person.id)

      Sharing.share_list(other_persons_list_shared, me.id)

      assert Sharing.other_lists(me.id) == [other_persons_list_shared]
    end

    test "create_shared_list/1 required properties" do
      {:error, changeset} =
        Sharing.create_shared_list(%{
          "name" => "",
          "due" => Date.utc_today() |> Date.add(-1),
          "owner_id" => nil
        })

      assert %{
               due: ["Must be after today"],
               name: ["can't be blank"],
               owner_id: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "create_shared_list/1 creates list" do
      %{id: user_id} = user_fixture()

      date = Date.utc_today()

      {:ok, shared_list} =
        Sharing.create_shared_list(%{
          "name" => "Test",
          "due" => Date.utc_today(),
          "owner_id" => user_id
        })

      assert %{name: "Test", due: ^date, owner_id: ^user_id} = shared_list
    end
  end
end
