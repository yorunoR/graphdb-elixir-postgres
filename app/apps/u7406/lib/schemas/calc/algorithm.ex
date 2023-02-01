defmodule Schemas.Calc.Algorithm do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Calc.Agency

  schema "algorithms" do
    belongs_to :agency, Agency

    field :name, :string
    field :arity, :integer

    timestamps()
    soft_delete_schema()
  end
end
