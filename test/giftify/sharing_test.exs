defmodule Giftify.SharingTest do
  use Giftify.DataCase

  alias Giftify.Sharing

  describe "shared_list" do
    alias Giftify.Sharing.SharedList

    import Giftify.SharingFixtures
    import Giftify.AccountsFixtures

    test "my_lists/1 returns only my lists" do
      me = user_fixture()
      other_person = user_fixture()

      my_list = shared_list_fixture(owner_id: me.id)
      other_persons_list = shared_list_fixture(owner_id: other_person.id)

      assert Sharing.my_lists(me.id) == [my_list]
    end

    test "other_lists/1 returns other persons lists shared with me" do
      me = user_fixture()
      other_person = user_fixture()

      my_list = shared_list_fixture(owner_id: me.id)
      other_persons_list_not_shared = shared_list_fixture(owner_id: other_person.id)
      other_persons_list_shared = shared_list_fixture(owner_id: other_person.id)

      Sharing.share_list(other_persons_list_shared, me.id)

      assert Sharing.other_lists(me.id) == [other_persons_list_shared]
    end
  end
end
