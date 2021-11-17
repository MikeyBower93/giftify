defmodule Giftify.Repo do
  use Ecto.Repo,
    otp_app: :giftify,
    adapter: Ecto.Adapters.Postgres
end
