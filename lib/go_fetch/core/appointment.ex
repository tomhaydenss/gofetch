defmodule GoFetch.Core.Appointment do
  @moduledoc """
   the appointment schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GoFetch.Core.Doctor
  alias GoFetch.Core.User
  alias GoFetch.Core.Pet

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
