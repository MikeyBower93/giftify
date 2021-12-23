defmodule GiftifyWeb.GiftLiveTest do
  use GiftifyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Giftify.UserInventoryFixtures

  defp create_gift(owner) do
    gift = gift_fixture(owner_id: owner.id)
    %{gift: gift}
  end

  describe "My gifts" do
    setup [:register_and_log_in_user]

    test "lists all my gifts", %{conn: conn, user: user} do
      %{gift: gift} = create_gift(user)

      {:ok, _index_live, html} = live(conn, Routes.gift_index_path(conn, :index))

      assert html =~ gift.name
      assert html =~ Decimal.to_string(gift.price)
    end

    test "Requires name and a price when creating a gift", %{conn: conn, user: _user} do
      {:ok, view, _html} = live(conn, Routes.gift_index_path(conn, :index))

      assert render_change(view, "validate", %{gift: %{name: "", price: ""}}) =~
               "can&#39;t be blank"
    end

    test "Creates a gift", %{conn: conn, user: _user} do
      {:ok, view, _html} = live(conn, Routes.gift_index_path(conn, :index))

      updated_html =
        view
        |> element("form")
        |> render_submit(%{gift: %{name: "My new item", price: "1234.23"}})

      assert updated_html =~ "My new item"
      assert updated_html =~ "1234.23"
    end
  end
end
