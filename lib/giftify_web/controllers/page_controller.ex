defmodule GiftifyWeb.PageController do
  use GiftifyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
