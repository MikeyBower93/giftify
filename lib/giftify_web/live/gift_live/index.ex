defmodule GiftifyWeb.GiftLive.Index do
  use GiftifyWeb, :live_view

  alias Giftify.Accounts
  alias Giftify.Accounts.User
  alias Giftify.UserInventory.Gift
  alias Giftify.UserInventory

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign_new(:current_user, fn ->
        find_current_user(session)
      end)
      |> initialise_form()

    {:ok, socket}
  end

  def handle_event("validate", %{"gift" => params}, socket) do
    params = Map.put(params, "owner_id", socket.assigns.current_user.id)

    changeset =
      %Gift{}
      |> UserInventory.change_gift(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"gift" => params}, socket) do
    params = Map.put(params, "owner_id", socket.assigns.current_user.id)

    case UserInventory.create_gift(params) do
      {:ok, _gift} ->
        {:noreply, initialise_form(socket)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  # Functions that deal with live view code

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token),
         do: user
  end

  defp initialise_form(socket) do
    socket
    |> assign(:gifts, list_gifts(socket.assigns.current_user))
    |> assign(:changeset, Gift.changeset(%Gift{}, %{}))
  end

  # Abstract/logical functions

  defp list_gifts(current_user) do
    UserInventory.list_owners_gifts(current_user.id)
  end
end
