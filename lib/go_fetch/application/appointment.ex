defmodule GoFetch.Appointment do
  @moduledoc """
   the appointment schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias GoFetch.Doctor
  alias GoFetch.User
  alias GoFetch.Pet
  alias GoFetch.Repo

  @doc """
  Update this function to return all appointments within the given range.
  """
  def get_appointments_by_date(%{start_date: start_date, end_date: end_date}) do
    query = from(a in __MODULE__, where: a.date >= ^start_date, where: a.date <= ^end_date)
    Repo.all(query)
  end

  schema "appointments" do
    field :date, :utc_datetime
    field :reason, :string

    belongs_to :user, User
    belongs_to :pet, Pet
    belongs_to :doctor, Doctor

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:date, :reason, :user_id, :pet_id], empty_values: [])
    |> validate_required([:date, :user_id, :pet_id])
  end
end
