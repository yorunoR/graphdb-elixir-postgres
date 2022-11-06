defmodule Graphql.Middlewares.ErrorHandler do
  require Logger

  @behaviour Absinthe.Middleware

  @impl true
  def call(resolution, _config) do
    errors =
      resolution.errors
      |> Enum.map(&normalize/1)
      |> List.flatten()

    %{resolution | errors: errors}
  end

  def normalize({:error, reason}) do
    handle(reason)
  end

  def normalize({:error, _operation, reason, _changes}) do
    handle(reason)
  end

  def normalize(other) do
    handle(other)
  end

  defp handle(code) when is_atom(code) do
    {status, message} = metadata(code)

    %{
      code: code,
      message: message,
      status_code: status
    }
  end

  defp handle(errors) when is_list(errors) do
    Enum.map(errors, &handle/1)
  end

  defp handle(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {err, _opts} -> err end)
    |> Enum.map(fn {k, v} ->
      %{
        code: :validation,
        message: String.capitalize("#{k} #{v}"),
        status_code: 422
      }
    end)
  end

  defp handle(%{message: message, code: code}) do
    {status, _message} = metadata(code)

    %{
      code: code,
      message: message,
      status_code: status
    }
  end

  defp handle(other) do
    Logger.error("Unhandled error term:\n#{inspect(other)}")
    handle(:unknown)
  end

  defp metadata(:unknown_resource), do: {400, "Unknown Resource"}
  defp metadata(:invalid_argument), do: {400, "Invalid arguments passed"}
  defp metadata(:unauthenticated), do: {401, "You need to be logged in"}
  defp metadata(:password_hash_missing), do: {401, "Reset your password to login"}
  defp metadata(:incorrect_password), do: {401, "Invalid credentials"}
  defp metadata(:unauthorized), do: {403, "You don't have permission to do this"}
  defp metadata(:not_found), do: {404, "Resource not found"}
  defp metadata(:user_not_found), do: {404, "User not found"}
  defp metadata(:unknown), do: {500, "Something went wrong"}

  defp metadata(code) do
    Logger.warn("Unhandled error code: #{inspect(code)}")
    {422, to_string(code)}
  end
end
