defmodule Schemas.Account.ProjectUser do
  use U7406.Schema

  alias Schemas.Account.Project
  alias Schemas.Account.User

  schema "project_users" do
    belongs_to :project, Project
    belongs_to :user, User

    field :privilege, :integer

    timestamps()
  end
end
