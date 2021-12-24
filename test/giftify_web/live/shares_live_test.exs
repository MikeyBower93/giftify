defmodule GiftifyWeb.SharesLiveTest do
  use GiftifyWeb.ConnCase, async: true

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

      other_persons_list_shared =
        shared_list_fixture(owner_id: other_person.id, name: "Other list")

      Sharing.share_list(other_persons_list_shared, user.id)

      {:ok, _index_live, html} = live(conn, Routes.shares_index_path(conn, :index))

      assert html =~ other_persons_list_shared.name
    end

    test "Clicking shared list opens modal", %{conn: conn, user: _user} do
      {:ok, index_live, _html} = live(conn, Routes.shares_index_path(conn, :index))

      assert render_click(index_live, :create_shared_list) =~ "create-shared-list-form"
    end

    test "Submitting modal creates item", %{conn: conn, user: _user} do
      {:ok, index_live, _html} = live(conn, Routes.shares_index_path(conn, :index))

      # Opens up the modal
      render_click(index_live, :create_shared_list)

      # Submits the form
      index_live
      |> element("form")
      |> render_submit(%{"create_form" => %{"due" => Date.utc_today(), "name" => "My shiny list"}})

      # Renders the live redirect and checks that we have the new item in the list
      assert index_live
             |> render()
             |> Floki.parse_document!()
             |> Floki.find("tr")
             |> Enum.any?(fn list_element -> Floki.raw_html(list_element) =~ "My shiny list" end)
    end

    test "Displays form errors", %{conn: conn, user: _user} do
      {:ok, index_live, _html} = live(conn, Routes.shares_index_path(conn, :index))

      # Opens up the modal
      render_click(index_live, :create_shared_list)

      # Validates form
      rendered_html =
        index_live
        |> element("form")
        |> render_submit(%{
          "create_form" => %{"due" => Date.utc_today() |> Date.add(-1), "name" => ""}
        })

      assert rendered_html =~ "Must be after today"
      assert rendered_html =~ "can&#39;t be blank"
    end

    test "Clicking manage sharees opens modal", %{conn: conn, user: user} do
      my_list = shared_list_fixture(owner_id: user.id)

      {:ok, index_live, _html} = live(conn, Routes.shares_index_path(conn, :index))

      assert render_click(index_live, :manage_sharees, %{
               "list-id" => Integer.to_string(my_list.id)
             }) =~ "manage-sharees-form"
    end

    test "Adding non existant user blanks form", %{conn: conn, user: user} do
      my_list = shared_list_fixture(owner_id: user.id)

      {:ok, index_live, _html} = live(conn, Routes.shares_index_path(conn, :index))

      render_click(index_live, :manage_sharees, %{"list-id" => Integer.to_string(my_list.id)})

      rendered_html =
        index_live
        |> element("form")
        |> render_submit(%{
          "sharee_form" => %{"email" => "non@exist.com"}
        })

      assert not (rendered_html =~ "non@exist.com")
    end

    test "Can delete sharee", %{conn: conn, user: user} do
      my_list = shared_list_fixture(owner_id: user.id)
      other_person = user_fixture()

      Sharing.share_list(my_list, other_person.id)

      {:ok, index_live, _html} = live(conn, Routes.shares_index_path(conn, :index))

      render_click(index_live, :manage_sharees, %{"list-id" => Integer.to_string(my_list.id)})

      rendered_html = element(index_live, "button", "Remove") |> render_click()

      assert not (rendered_html =~ other_person.email)
    end
  end
end
