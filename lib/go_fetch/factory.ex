defmodule GoFetch.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: GoFetch.Repo

  alias GoFetch.Core.{Appointment, Doctor, Pet, User}

  def user_factory do
    %User{
      email: Faker.Internet.email(),
      name: Faker.Person.name()
    }
  end

  def pet_factory do
    %Pet{
      name: Faker.Cat.name(),
      user: build(:user)
    }
  end

  def doctor_factory do
    %Doctor{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name()
    }
  end

  def appointment_factory do
    %Appointment{
      date: Faker.DateTime.forward(Enum.random(1..30)),
      reason: Faker.Lorem.sentence(),
      user: build(:user),
      pet: build(:pet),
      doctor: build(:doctor)
    }
  end
end
