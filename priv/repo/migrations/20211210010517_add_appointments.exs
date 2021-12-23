defmodule GoFetch.Repo.Migrations.AddAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :date, :utc_datetime, null: false
      add :reason, :string
      add :user_id, references(:users), null: false
      add :pet_id, references(:pets), null: false

      timestamps()
    end
  end
end
