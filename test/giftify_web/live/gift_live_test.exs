defmodule GiftifyWeb.GiftLiveTest do
  use GiftifyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Giftify.UserInventoryFixtures

  defp create_gift(_) do
    gift = gift_fixture()
    %{gift: gift}
  end

  describe "Index" do
    setup [:create_gift]

    # test "lists all gifts", %{conn: conn, gift: gift} do
    #   {:ok, _index_live, html} = live(conn, Routes.gift_index_path(conn, :index))

    #   assert html =~ "Listing Gifts"
    #   assert html =~ gift.name
    # end
  end
end
