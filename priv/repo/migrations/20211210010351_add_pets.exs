defmodule GoFetch.Repo.Migrations.AddPets do
  use Ecto.Migration

  def change do
    create table(:pets) do
      add :name, :string
      add :user_id, references(:users), null: false

      timestamps()
    end
  end
end
