defmodule Schemas.Account.Project do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.ProjectUser
  # alias Schemas.Graph.Tower

  schema "projects" do
    field :default, :boolean
    field :name, :string

    timestamps()
    soft_delete_schema()

    has_many :project_users, ProjectUser, on_delete: :delete_all
    has_many :users, through: [:project_users, :user]
    # has_many :towers, Tower, on_delete: :delete_all
  end
end
