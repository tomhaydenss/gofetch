defmodule GoFetchWeb.PageControllerTest do
  use GoFetchWeb.ConnCase

  describe "index" do
    test "GET /", %{conn: conn} do
      conn = get(conn, Routes.page_path(conn, :index))

      assert html_response(conn, 200) =~ "<div id=\"react-app\"></div>"
    end
  end
end
