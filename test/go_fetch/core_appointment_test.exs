defmodule GoFetch.CoreAppointmentTest do
  use GoFetch.DataCase
  alias GoFetch.Core

  import GoFetch.Factory

  @two_days_in_seconds 172_800
  @thirty_days_in_seconds 2_592_000

  setup do
    # Search start & end points
    start_search_today = DateTime.utc_now()
    end_search_in_two_days = DateTime.add(start_search_today, @two_days_in_seconds)
    future_appt_earliest = DateTime.add(end_search_in_two_days, 1, :second)
    future_appt_latest = DateTime.add(start_search_today, @thirty_days_in_seconds, :second)

    %{
      start_date: start_search_today,
      end_date: end_search_in_two_days,
      future_appt_earliest: future_appt_earliest,
      future_appt_latest: future_appt_latest
    }
  end

  describe "get_appointments_by_date/1" do
    test "only returns appointments from within the given timeframe", %{
      start_date: start_search_today,
      end_date: end_search_in_two_days,
      future_appt_earliest: future_appt_earliest,
      future_appt_latest: future_appt_latest
    } do
      # Add appointments outside of search range
      _past_appointment = insert(:appointment, %{date: Faker.DateTime.backward(30)})

      _future_appointment =
        insert(:appointment, %{
          date: Faker.DateTime.between(future_appt_earliest, future_appt_latest)
        })

      # Add appointment within range
      valid_appointment =
        insert(:appointment, %{
          date: Faker.DateTime.between(start_search_today, end_search_in_two_days)
        })

      appointments =
        Core.get_appointments_by_date(%{
          start_date: DateTime.to_string(start_search_today),
          end_date: DateTime.to_string(end_search_in_two_days)
        })

      assert length(appointments) == 1
      [appointment] = appointments
      assert appointment.date == valid_appointment.date
    end
  end

  describe "get_appointments_by_date_and_doctor/3" do
    test "only return appointments from within the given timeframe and from selected doctor", %{
      start_date: start_search_today,
      end_date: end_search_in_two_days,
      future_appt_earliest: future_appt_earliest,
      future_appt_latest: future_appt_latest
    } do
      good_doctor = insert(:doctor)
      another_good_doctor = insert(:doctor)

      # Add appointments outside of search range
      _past_appointment_with_the_doctor =
        insert(:appointment, %{date: Faker.DateTime.backward(30), doctor: good_doctor})

      _future_appointment_with_the_doctor =
        insert(:appointment, %{
          date: Faker.DateTime.between(future_appt_earliest, future_appt_latest),
          doctor: good_doctor
        })

      # Add appointment within range
      _valid_date_but_with_different_doctor =
        insert(:appointment, %{
          date: Faker.DateTime.between(start_search_today, end_search_in_two_days),
          doctor: another_good_doctor
        })

      valid_appointment =
        insert(:appointment, %{
          date: Faker.DateTime.between(start_search_today, end_search_in_two_days),
          doctor: good_doctor
        })

      start_date = DateTime.to_string(start_search_today)
      end_date = DateTime.to_string(end_search_in_two_days)

      appointments =
        Core.get_appointments_by_date_and_doctor(start_date, end_date, good_doctor.id)

      assert length(appointments) == 1
      [appointment] = appointments
      assert appointment.date == valid_appointment.date
    end
  end
end
