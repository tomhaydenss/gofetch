defmodule GoFetch.Repo.Migrations.AlterAppointments do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :doctor_id, references(:doctors), null: false
    end
  end
end
