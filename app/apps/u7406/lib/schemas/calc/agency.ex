defmodule Schemas.Calc.Agency do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Calc.Algorithm

  schema "agencies" do
    field :name, :string

    timestamps()
    soft_delete_schema()

    has_many :algorithms, Algorithm, on_delete: :delete_all
  end
end
