defmodule GoFetchWeb.PageController do
  use GoFetchWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
