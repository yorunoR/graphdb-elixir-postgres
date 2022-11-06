defmodule U7406.MigrationsHelper do
  use Ecto.Migration

  def add_policies(table_name, references \\ []) do
    add_admin_policy(table_name)
    add_user_policy(table_name, references)

    enable_rls(table_name)
  end

  def remove_policies(table_name) do
    execute("DROP POLICY admin_policy ON #{table_name}")
    execute("DROP POLICY user_policy ON #{table_name}")
    execute("ALTER TABLE #{table_name} NO FORCE ROW LEVEL SECURITY")
    execute("ALTER TABLE #{table_name} DISABLE ROW LEVEL SECURITY")
  end

  defp squeeze(str) do
    str
    |> String.replace(~r/\s+/, " ")
    |> String.trim(" ")
  end

  defp enable_rls(table_name) do
    execute("ALTER TABLE #{table_name} ENABLE ROW LEVEL SECURITY")
    execute("ALTER TABLE #{table_name} FORCE ROW LEVEL SECURITY")
  end

  defp add_admin_policy(table_name) do
    execute(
      "CREATE POLICY admin_policy ON #{table_name} FOR ALL USING ( current_setting('session.access_role', true) = 'admin' )"
    )
  end

  def add_user_policy(table_name, references) do
    create_policy = """
    CREATE POLICY user_policy ON #{table_name} FOR ALL USING (
      current_setting('session.access_role', true) = 'user' AND current_setting('session.project_id', true) = project_id::text
    )
    """

    check_references =
      references
      |> Enum.map(fn reference ->
        reference_table = reference[:belongs_to]
        reference_id = reference[:id]

        """
        (SELECT EXISTS (
          SELECT * FROM #{reference_table}
          WHERE #{reference_table}.id = #{table_name}.#{reference_id} AND #{reference_table}.project_id::text = current_setting('session.project_id', true)
        ))
        """
      end)

    query =
      case check_references do
        [] ->
          create_policy

        _ ->
          create_policy <> ~s/WITH CHECK (#{Enum.join(check_references, " AND ")})/
      end

    execute(squeeze(query))
  end
end
