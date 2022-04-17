defmodule GoFetchWeb.SchemaAppointmentTest do
  use GoFetchWeb.ConnCase

  import GoFetch.Factory

  describe "querying appointments" do
    @list_appointments_query """
    query ListAppointments($startDate: String!, $endDate: String!, $doctorId: ID) {
      appointments(startDate: $startDate, endDate: $endDate, doctorId: $doctorId) {
        id
        reason
        date

        doctor {
          id
          firstName
          lastName
        }

        user {
          id
          email
          name
        }

        pet {
          id
          name
        }
      }
    }
    """
    defp send_list_appointments_request(conn, start_date, end_date, doctor_id \\ nil) do
      variables =
        if doctor_id do
          %{startDate: start_date, endDate: end_date, doctorId: doctor_id}
        else
          %{startDate: start_date, endDate: end_date}
        end

      post(conn, "/api", %{
        "query" => @list_appointments_query,
        "variables" => variables
      })
    end

    setup do
      today = Date.utc_today()
      {:ok, start_datetime, _} = DateTime.from_iso8601("#{Date.to_iso8601(today)}T00:00:00.000Z")
      {:ok, end_datetime, _} = DateTime.from_iso8601("#{Date.to_iso8601(today)}T23:59:59.999Z")

      %{start_datetime: start_datetime, end_datetime: end_datetime}
    end

    test "by date whose register is within the given period", %{
      conn: conn,
      start_datetime: start_datetime,
      end_datetime: end_datetime
    } do
      insert(:appointment, %{
        date: Faker.DateTime.between(start_datetime, end_datetime)
      })

      body =
        conn
        |> send_list_appointments_request(
          DateTime.to_iso8601(start_datetime),
          DateTime.to_iso8601(end_datetime)
        )
        |> json_response(200)

      assert %{
               "data" => %{
                 "appointments" => [
                   %{
                     "date" => _,
                     "doctor" => %{
                       "firstName" => _,
                       "id" => _,
                       "lastName" => _
                     },
                     "id" => _,
                     "pet" => %{"id" => _, "name" => _},
                     "reason" => _,
                     "user" => %{
                       "email" => _,
                       "id" => _,
                       "name" => _
                     }
                   }
                 ]
               }
             } = body
    end

    test "by date whose register is outside of the given period", %{
      conn: conn,
      start_datetime: start_datetime,
      end_datetime: end_datetime
    } do
      _appointment_before_period =
        insert(:appointment, %{
          date: Faker.DateTime.backward(1)
        })

      _appointment_after_period =
        insert(:appointment, %{
          date: Faker.DateTime.forward(1)
        })

      body =
        conn
        |> send_list_appointments_request(
          DateTime.to_iso8601(start_datetime),
          DateTime.to_iso8601(end_datetime)
        )
        |> json_response(200)

      assert %{
               "data" => %{
                 "appointments" => []
               }
             } = body
    end

    test "by date and doctor whose both register's date and doctor match with given params",
         %{
           conn: conn,
           start_datetime: start_datetime,
           end_datetime: end_datetime
         } do
      doctor_id = "7"
      doctor_first_name = "Shaun"
      doctor_last_name = "Murphy"

      doctor =
        insert(:doctor, %{
          id: doctor_id,
          first_name: doctor_first_name,
          last_name: doctor_last_name
        })

      insert(:appointment, %{
        date: Faker.DateTime.between(start_datetime, end_datetime),
        doctor: doctor
      })

      body =
        conn
        |> send_list_appointments_request(
          DateTime.to_iso8601(start_datetime),
          DateTime.to_iso8601(end_datetime),
          doctor_id
        )
        |> json_response(200)

      assert %{
               "data" => %{
                 "appointments" => [
                   %{
                     "date" => _,
                     "doctor" => %{
                       "firstName" => ^doctor_first_name,
                       "id" => ^doctor_id,
                       "lastName" => ^doctor_last_name
                     },
                     "id" => _,
                     "pet" => %{"id" => _, "name" => _},
                     "reason" => _,
                     "user" => %{
                       "email" => _,
                       "id" => _,
                       "name" => _
                     }
                   }
                 ]
               }
             } = body
    end

    test "by date and doctor whose both register's date and doctor don't match with given params",
         %{
           conn: conn,
           start_datetime: start_datetime,
           end_datetime: end_datetime
         } do
      doctor_id = "7"
      doctor_first_name = "Shaun"
      doctor_last_name = "Murphy"

      doctor =
        insert(:doctor, %{
          id: doctor_id,
          first_name: doctor_first_name,
          last_name: doctor_last_name
        })

      _appointment_with_right_doctor_but_wrong_date =
        insert(:appointment, %{
          date: Faker.DateTime.backward(30),
          doctor: doctor
        })

      _appointment_with_right_date_but_wrong_doctor =
        insert(:appointment, %{
          date: Faker.DateTime.between(start_datetime, end_datetime)
        })

      body =
        conn
        |> send_list_appointments_request(
          DateTime.to_iso8601(start_datetime),
          DateTime.to_iso8601(end_datetime),
          doctor_id
        )
        |> json_response(200)

      assert %{
               "data" => %{
                 "appointments" => []
               }
             } = body
    end
  end
end
