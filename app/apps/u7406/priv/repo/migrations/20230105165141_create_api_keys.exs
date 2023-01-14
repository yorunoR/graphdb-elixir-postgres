defmodule U7406.Repo.Migrations.CreateApiKeys do
  use Ecto.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:api_keys) do
      add :project_id, references(:users, on_delete: :nothing), null: false
      add :name, :string, null: false
      add :short_token, :string, null: false
      add :hash, :string, null: false
      add :value, :string, null: false

      timestamps()
    end

    create index(:api_keys, [:project_id])

    add_policies(:api_keys)
  end

  def down do
    drop table(:api_keys)
  end
end
