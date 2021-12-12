defmodule GiftifyWeb.LiveHelpers do
  @moduledoc false

  alias Giftify.Accounts
  alias Giftify.Accounts.User

  import Phoenix.LiveView, only: [assign_new: 3]

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token),
         do: user
  end

  def assign_user(socket, session) do
    assign_new(socket, :current_user, fn ->
      find_current_user(session)
    end)
  end
end
