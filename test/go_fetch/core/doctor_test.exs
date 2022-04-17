defmodule GoFetch.Core.DoctorTest do
  use GoFetch.DataCase

  alias GoFetch.Core.Doctor

  @valid_attrs %{first_name: "Shaun", last_name: "Murphy"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Doctor.changeset(%Doctor{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Doctor.changeset(%Doctor{}, @invalid_attrs)
    refute changeset.valid?
  end
end
