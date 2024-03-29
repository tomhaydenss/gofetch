defmodule GoFetch.Core.UserTest do
  use GoFetch.DataCase

  alias GoFetch.Core.User

  @valid_attrs %{name: "naoto", email: "naoto@san.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
