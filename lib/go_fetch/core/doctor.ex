defmodule GoFetch.Core.Doctor do
  @moduledoc """
   the doctor schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GoFetch.Core.Appointment

  schema "doctors" do
    field :first_name, :string
    field :last_name, :string

    has_many :appointments, Appointment

    timestamps()
  end

  @doc false
  def changeset(doctor, attrs) do
    doctor
    |> cast(attrs, [:first_name, :last_name], empty_values: [])
    |> validate_required([:first_name, :last_name])
  end
end
