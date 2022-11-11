defmodule Schemas.Calc.Algorithm do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  schema "algorithms" do
    field :name, :string

    timestamps()
    soft_delete_schema()
  end
end
