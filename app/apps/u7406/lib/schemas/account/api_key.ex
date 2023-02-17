defmodule Schemas.Account.ApiKey do
  use U7406.Schema

  alias Schemas.Account.Project

  schema "api_keys" do
    belongs_to :project, Project

    field :name, :string
    field :short_token, :string
    field :hash, :string
    field :value, :string

    timestamps()
  end
end
