defmodule GiftifyWeb.SharesLive.ManageShareesComponent do
  @moduledoc false

  use GiftifyWeb, :live_component

  alias Giftify.Accounts
  alias Giftify.Sharing

  @impl true
  def render(assigns) do
    ~H"""
      <div>
        <label>Sharees</label>
        <table>
          <%= for sharee <- @shared_list.sharees do %>
            <tr>
              <td><%= sharee.email %></td>
              <td>
                <button class="list_button_td" phx-target={@myself} phx-click="delete_sharee" phx-value-sharee-id={"#{sharee.id}"}>Remove</button>
              </td>
            </tr>
          <% end %>
        </table>
        <.form let={f} for={@changeset} phx-submit="save" as={:sharee_form} phx-target={@myself} data-test="manage-sharees-form">
          <%= label f, :email %>
          <%= email_input f, :email %>
          <%= error_tag f, :email %>

          <%= submit "Add" %>
        </.form>
      </div>
    """
  end

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    shared_list = Sharing.get_list(assigns.list_id, [:sharees])

    socket =
      socket
      |> assign(:shared_list, shared_list)
      |> assign(:changeset, get_changeset(%{email: ""}, :insert))

    {:ok, socket}
  end

  @impl true
  def handle_event("save", %{"sharee_form" => %{"email" => email}}, socket) do
    case Accounts.get_user_by_email(email) do
      nil ->
        {:noreply, assign(socket, :changeset, get_changeset(%{email: ""}, :update))}

      sharee ->
        Sharing.share_list(socket.assigns.shared_list, sharee.id)
        shared_list = Sharing.get_list(socket.assigns.shared_list.id, [:sharees])

        socket =
          socket
          |> assign(:shared_list, shared_list)
          |> assign(:changeset, get_changeset(%{email: ""}, :update))

        {:noreply, socket}
    end
  end

  @impl true
  def handle_event("delete_sharee", %{"sharee-id" => sharee_id}, socket) do
    Sharing.remove_sharee_from_list(sharee_id, socket.assigns.shared_list)
    shared_list = Sharing.get_list(socket.assigns.shared_list.id, [:sharees])

    {:noreply, assign(socket, :shared_list, shared_list)}
  end

  defp get_changeset(params, action) do
    data = %{}
    types = %{email: :string}

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Map.put(:action, action)
  end
end
