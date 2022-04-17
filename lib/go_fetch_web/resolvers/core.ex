defmodule GoFetchWeb.Resolvers.Core do
  @moduledoc """
  GraphQL Resolvers
  """

  alias GoFetch.Core

  def list_doctors(_, _, _) do
    {:ok, Core.get_doctors()}
  end

  def list_appointments(_, %{start_date: start_date, end_date: end_date, doctor_id: doctor_id}, _) do
    {:ok, Core.get_appointments_by_date_and_doctor(start_date, end_date, doctor_id)}
  end

  def list_appointments(_, args, _) do
    {:ok, Core.get_appointments_by_date(args)}
  end
end
