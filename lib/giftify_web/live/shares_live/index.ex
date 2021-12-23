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
      |> reset_state()

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    socket =
      socket
      |> assign_my_lists()
      |> assign_other_lists()
      |> reset_state()

    {:noreply, socket}
  end

  defp assign_my_lists(socket) do
    assign(socket, :my_lists, Sharing.my_lists(socket.assigns.current_user.id))
  end

  defp assign_other_lists(socket) do
    assign(socket, :other_lists, Sharing.other_lists(socket.assigns.current_user.id))
  end

  defp reset_state(socket) do
    socket
    |> assign(:create_shared_list_enabled, false)
    |> assign(:manage_sharees_enabled, false)
  end

  @impl true
  def handle_event("create_shared_list", _value, socket) do
    {:noreply, assign(socket, :create_shared_list_enabled, true)}
  end

  @impl true
  def handle_event("manage_sharees", %{"list-id" => list_id}, socket) do
    {list_id, _} = Integer.parse(list_id)

    if not Enum.any?(socket.assigns.my_lists, &(&1.id == list_id)) do
      raise "Invalid list id"
    end

    socket =
      socket
      |> assign(:manage_sharees_enabled, true)
      |> assign(:active_shared_list_id, list_id)

    {:noreply, socket}
  end
end
