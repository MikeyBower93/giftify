defmodule GiftifyWeb.SharesLiveTest do
  use GiftifyWeb.ConnCase

  alias Giftify.Sharing

  import Phoenix.LiveViewTest
  import Giftify.SharingFixtures
  import Giftify.AccountsFixtures

  describe "Shares" do
    setup [:register_and_log_in_user]

    test "Shows my lists", %{conn: conn, user: user} do
      my_list = shared_list_fixture(owner_id: user.id, name: "My list")

      {:ok, _index_live, html} = live(conn, Routes.shares_index_path(conn, :index))

      assert html =~ my_list.name
    end

    test "Other lists", %{conn: conn, user: user} do
      other_person = user_fixture()

      other_persons_list_shared = shared_list_fixture(owner_id: other_person.id, name: "Other list")

      Sharing.share_list(other_persons_list_shared, user.id)

      {:ok, _index_live, html} = live(conn, Routes.shares_index_path(conn, :index))

      assert html =~ other_persons_list_shared.name
    end
  end
end
