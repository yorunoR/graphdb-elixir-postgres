defmodule Schemas.Account.User do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.ProjectUser

  schema "users" do
    field :activated, :boolean
    field :email, :string
    field :name, :string
    field :profile_image, :string
    field :role, :integer
    field :uid, :string
    field :anonymous, :boolean

    timestamps()
    soft_delete_schema()

    has_many :project_users, ProjectUser, on_delete: :delete_all
    has_many :projects, through: [:project_users, :project]
  end
end
