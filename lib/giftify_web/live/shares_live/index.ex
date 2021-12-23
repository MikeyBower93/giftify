defmodule GiftifyWeb.SharesLive.Index do
  @moduledoc false

  use GiftifyWeb, :live_view

  alias Giftify.Sharing

  import GiftifyWeb.LiveHelpers

  # ----------- Functions that deal with live view code ----------

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign_user(session)
      |> assign_my_lists()
      |> assign_other_lists()
      |> assign(:create_shared_list_enabled, false)

    {:ok, socket}
  end

  @impl
  def handle_params(_params, _uri, socket) do
    socket =
      socket
      |> assign_my_lists()
      |> assign_other_lists()
      |> assign(:create_shared_list_enabled, false)

    {:noreply, socket}
  end

  defp assign_my_lists(socket) do
    assign(socket, :my_lists, Sharing.my_lists(socket.assigns.current_user.id))
  end

  defp assign_other_lists(socket) do
    assign(socket, :other_lists, Sharing.other_lists(socket.assigns.current_user.id))
  end

  @impl
  def handle_event("create_shared_list", _value, socket) do
    {:noreply, assign(socket, :create_shared_list_enabled, true)}
  end
end
