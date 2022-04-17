defmodule GoFetch.CoreDoctorTest do
  use GoFetch.DataCase
  alias GoFetch.Core

  import GoFetch.Factory

  describe "get_doctors/0" do
    test "should return all registered doctors" do
      _good_doctor = insert(:doctor, %{first_name: "Shaun", last_name: "Murphy"})
      _another_good_doctor = insert(:doctor, %{first_name: "Gregory", last_name: "House"})

      doctors = Core.get_doctors()

      assert length(doctors) == 2
      assert [first, second] = doctors
      assert first.last_name == "House"
      assert second.last_name == "Murphy"
    end
  end
end
