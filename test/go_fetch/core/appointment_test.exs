defmodule GoFetch.Core.AppointmentTest do
  use GoFetch.DataCase

  alias GoFetch.Core.Appointment

  @valid_attrs %{
    date: DateTime.utc_now(),
    reason: "painful body",
    user_id: 17,
    pet_id: 7
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Appointment.changeset(%Appointment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Appointment.changeset(%Appointment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
