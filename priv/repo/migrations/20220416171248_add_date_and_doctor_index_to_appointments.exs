defmodule GoFetch.Repo.Migrations.AddDateAndDoctorIndexToAppointments do
  use Ecto.Migration

  def change do
    create index(:appointments, [:date, :doctor_id])
  end
end
