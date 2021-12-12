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

    {:ok, assign_user(socket, session)}
  end

  defp assign_my_lists(socket) do
    assign(socket, :my_lists, Sharing.my_lists(socket.assigns.current_user.id))
  end

  defp assign_other_lists(socket) do
    assign(socket, :other_lists, Sharing.other_lists(socket.assigns.current_user.id))
  end
end
