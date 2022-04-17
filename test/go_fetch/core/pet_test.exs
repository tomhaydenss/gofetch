defmodule GoFetch.Core.PetTest do
  use GoFetch.DataCase

  alias GoFetch.Core.Pet

  @valid_attrs %{name: "nori", user_id: 17}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pet.changeset(%Pet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pet.changeset(%Pet{}, @invalid_attrs)
    refute changeset.valid?
  end
end
