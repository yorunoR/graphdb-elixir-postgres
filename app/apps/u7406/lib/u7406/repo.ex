defmodule U7406.Repo do
  use Ecto.Repo,
    otp_app: :u7406,
    adapter: Ecto.Adapters.Postgres

  def as_admin(txn) when is_function(txn) do
    result =
      transaction(
        fn ->
          query!("SELECT set_config('session.access_role', 'admin', true)")

          case txn.() do
            {:error, error} -> rollback(error)
            success -> success
          end
        end,
        timeout: :infinity
      )

    case result do
      {:ok, res} -> res
      error -> error
    end
  end

  def as_user(project_id, txn) when is_function(txn) do
    result =
      transaction(
        fn ->
          query!("SELECT set_config('session.access_role', 'user', true)")
          query!("SELECT set_config('session.project_id', '#{project_id}', true)")

          case txn.() do
            {:error, error} -> rollback(error)
            success -> success
          end
        end,
        timeout: :infinity
      )

    case result do
      {:ok, res} -> res
      error -> error
    end
  end

  def admin_all(query) do
    as_admin(fn ->
      all(query)
    end)
  end
end
