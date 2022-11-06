defmodule U7406.Repo.Migrations.CreateProjectUsers do
  use Ecto.Migration

  def change do
    create table(:project_users) do
      add :privilege, :integer, null: false
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:project_users, [:project_id])
    create index(:project_users, [:user_id])
  end
end
