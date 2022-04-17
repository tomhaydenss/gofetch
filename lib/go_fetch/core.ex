defmodule GoFetch.Core do
  @moduledoc """
  The Core context.
  """
  import Ecto.Query
  alias GoFetch.Core.Appointment
  alias GoFetch.Core.Doctor
  alias GoFetch.Repo

  @doc """
  Get all doctors
  """
  def get_doctors do
    Repo.all(from Doctor, order_by: [:last_name])
  end

  @doc """
  Update this function to return all appointments within the given range.
  """
  def get_appointments_by_date(%{start_date: start_date, end_date: end_date}) do
    from(a in Appointment)
    |> query_by_date_period(start_date, end_date)
    |> Repo.all()
  end

  @doc """
  Gets appointments by a given period and doctor.
  """
  def get_appointments_by_date_and_doctor(start_date, end_date, doctor_id) do
    from(a in Appointment)
    |> query_by_date_period(start_date, end_date)
    |> query_by_doctor_id(doctor_id)
    |> order_by(asc: :date)
    |> Repo.all()
  end

  defp query_by_date_period(queryable, start_date, end_date) do
    from(a in queryable, where: a.date >= ^start_date, where: a.date <= ^end_date)
  end

  defp query_by_doctor_id(queryable, doctor_id) do
    from(a in queryable, where: a.doctor_id == ^doctor_id)
  end
end
