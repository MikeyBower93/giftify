defmodule GiftifyWeb.SharesLive.CreateSharedListComponent do
  @moduledoc false

  use GiftifyWeb, :live_component

  alias Giftify.Sharing
  alias Giftify.Sharing.SharedList

  def render(assigns) do
    ~H"""
      <div>
        <.form let={f} as={:create_form} for={@changeset} phx-change="validate" phx-submit="save" phx-target={@myself} data-test="create-shared-list-form">
          <div>
            <%= label f, :name %>
            <%= text_input f, :name %>
            <%= error_tag f, :name %>
          </div>

          <div>
            <%= label f, :due %>
            <%= date_select f, :due %>
            <%= error_tag f, :due %>
          </div>

          <%= submit "Save" %>
        </.form>
      </div>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    params = %{name: "", due: Date.utc_today(), owner_id: assigns.owner_id}

    socket =
      socket
      |> assign(:owner_id, assigns.owner_id)
      |> assign(:changeset, get_changeset(params, :insert))

    {:ok, socket}
  end

  @impl
  def handle_event("validate", %{"create_form" => params}, socket) do
    params = Map.put(params, "owner_id", socket.assigns.owner_id)

    {:noreply, assign(socket, :changeset, get_changeset(params, :update))}
  end

  @impl
  def handle_event("save", %{"create_form" => params}, socket) do
    params = Map.put(params, "owner_id", socket.assigns.owner_id)

    case Sharing.create_shared_list(params) do
      {:ok, _shared_list} -> {:noreply, push_patch(socket, to: "/shares")}
      {:error, changeset} -> {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp get_changeset(params, action) do
    %SharedList{}
    |> Sharing.change_shared_list(params)
    |> Map.put(:action, action)
  end
end
