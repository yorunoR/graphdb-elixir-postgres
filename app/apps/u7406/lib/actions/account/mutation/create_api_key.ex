defmodule Actions.Account.Mutation.CreateApiKey do
  import Ecto.Changeset
  import U7406

  alias Actions.Account.Mixin.ApiKeyFuncs.Crypt
  alias Schemas.Account.ApiKey
  alias U7406.Repo

  def run(_parent, args, context) do
    %{current_project: project} = context
    %{api_key: attrs} = args

    api_key =
      build_assoc(project, :api_keys)
      |> create_api_key_changeset(attrs)
      |> Repo.insert!()

    {:ok, api_key}
  end

  def create_api_key_changeset(%ApiKey{} = api_key, attrs) do
    user_salt = "ApiKey" <> to_string(api_key.project_id)

    api_key
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> put_api_key(user_salt)
  end

  def put_api_key(changeset, user_salt) do
    {:ok, key} = PrefixedApiKey.generate("mildeaw")
    value = key.api_key |> Crypt.encrypt(user_salt)

    changeset
    |> put_change(:short_token, key.short_token)
    |> put_change(:hash, key.hash)
    |> put_change(:value, value)
  end
end
