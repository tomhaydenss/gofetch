defmodule GoFetchWeb.SchemaDoctorTest do
  use GoFetchWeb.ConnCase

  import GoFetch.Factory

  describe "querying doctors" do
    @list_doctors_query """
    query ListDoctors {
      doctors {
        id
        firstName
        lastName
      }
    }
    """
    defp send_list_doctors_request(conn) do
      post(conn, "/api", %{
        "query" => @list_doctors_query
      })
    end

    test "should return empty array when there is no doctors registered", %{
      conn: conn
    } do
      body =
        conn
        |> send_list_doctors_request()
        |> json_response(200)

      assert %{
               "data" => %{
                 "doctors" => []
               }
             } = body
    end

    test "should return all doctors registered", %{
      conn: conn
    } do
      doctors_quantity = 5
      insert_list(doctors_quantity, :doctor)

      body =
        conn
        |> send_list_doctors_request()
        |> json_response(200)

      assert %{
               "data" => %{
                 "doctors" => doctors_list
               }
             } = body

      assert length(doctors_list) == doctors_quantity
    end
  end
end
