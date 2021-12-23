defmodule GoFetch.Seed do
  import GoFetch.Factory

  alias GoFetch.Repo

  def generate do
    Repo.transaction(
      fn ->
        num_users_to_create = Enum.random(10..20)

        IO.puts("Create Users")
        users = insert_list(10, :user)

        IO.puts("Create Pets")
        pets =
          users
          |> Enum.map(fn user ->
            insert_list(Enum.random(1..3), :pet, %{user: user})
          end)
          |> List.flatten()

        IO.puts("Create Doctors")
        doctors = insert_list(5, :doctor)

        IO.puts("Create Appointments")
        appointments = Enum.map(pets, fn pet ->
          doctor = Enum.random(doctors)
          # insert past appointment and a current day appointment
          insert(:appointment, %{pet: pet, doctor: doctor, user: pet.user, date: Faker.DateTime.forward(Enum.random(1..7))})
          insert(:appointment, %{pet: pet, doctor: doctor, user: pet.user, date: Faker.DateTime.backward(Enum.random(1..30))})
        end)
      end,
      timeout: :infinity
    )
  end
end
