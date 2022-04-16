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
    from(a in __MODULE__)
    |> query_by_date_period(start_date, end_date)
    |> Repo.all()
  end

  @doc """
  Gets appointments by a given period and doctor.
  """
  def get_appointments_by_date_and_doctor(start_date, end_date, doctor_id) do
    from(a in __MODULE__)
    |> query_by_date_period(start_date, end_date)
    |> query_by_doctor_id(doctor_id)
    |> order_by([asc: :date])
    |> Repo.all()
  end

  defp query_by_date_period(queryable, start_date, end_date) do
    from a in queryable, where: a.date >= ^start_date, where: a.date <= ^end_date
  end

  defp query_by_doctor_id(queryable, doctor_id) do
    from a in queryable, where: a.doctor_id == ^doctor_id
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
