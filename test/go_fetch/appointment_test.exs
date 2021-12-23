defmodule GoFetch.AppointmentTest do
  use ExUnit.Case
  alias GoFetch.Appointment

  import GoFetch.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GoFetch.Repo)
  end

  describe "get_appointments_by_date/1" do
    test "only returns appointments from within the given timeframe" do
      past_appointment = insert(:appointment, %{date: Faker.DateTime.backward(30)})
      future_appointment = insert(:appointment, %{date: Faker.DateTime.forward(30)})
      valid_appointment = insert(:appointment, %{date: Faker.DateTime.forward(2)})

      start_date = DateTime.utc_now()
      end_date = DateTime.add(start_date, 172_800)

      appointments =
        Appointment.get_appointments_by_date(%{
          start_date: DateTime.to_string(start_date),
          end_date: DateTime.to_string(end_date)
        })

      assert length(appointments) == 1
      [appointment] = appointments
      assert appointment.date == valid_appointment.date
    end
  end
end
