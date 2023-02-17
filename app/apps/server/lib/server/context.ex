defmodule Server.Context do
  require Logger

  import Plug.Conn

  alias Resolvers.AccountResolver

  @cert_url "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com"

  def build_context(conn) do
    with [project_key] <- get_req_header(conn, "x-mildeaw-project-key"),
         [api_key] <- get_req_header(conn, "x-mildeaw-api-key"),
         ["mildeaw", short_token, _] <- String.split(api_key, "_"),
         {:ok, {current_project, hash}} = get_project_and_hash(project_key, short_token),
         true = PrefixedApiKey.verify?(api_key, hash) do
      %{
        current_user: nil,
        current_project: current_project
      }
    else
      api_err ->
        with [project_id] <- get_req_header(conn, "cid"),
             ["Bearer " <> token] <- get_req_header(conn, "authorization"),
             {:ok, verified = %{"user_id" => uid}} <- verify(token),
             {:ok, {current_user, current_project}} =
               get_user_and_project(uid, String.to_integer(project_id)) do
          case verified do
            %{"email" => email, "name" => name} ->
              %{
                current_user: current_user,
                email: email,
                uid: uid,
                name: name,
                current_project: current_project,
                anonymous: false
              }

            %{"provider_id" => "anonymous"} ->
              %{
                current_user: current_user,
                uid: uid,
                current_project: current_project,
                anonymous: true
              }
          end
        else
          user_err ->
            api_err |> inspect |> Logger.error()
            user_err |> inspect |> Logger.error()
            %{}
        end
    end
  end

  def get_project_and_hash(project_key, short_token) do
    AccountResolver.call(
      :project_and_hash,
      nil,
      %{project_key: project_key, short_token: short_token},
      %{context: nil}
    )
  end

  def get_user_and_project(nil, _) do
    {:ok, {nil, nil}}
  end

  def get_user_and_project(uid, nil) do
    get_user_and_project(uid, 0)
  end

  def get_user_and_project(uid, project_id) do
    AccountResolver.call(
      :user_and_project,
      nil,
      %{uid: uid, project_id: project_id},
      %{context: nil}
    )
  end

  def verify(token) do
    case Joken.peek_header(token) do
      {:ok, header} ->
        cert = get_cert(header["kid"])
        {true, jose_jwt, _} = JOSE.JWT.verify(cert, token)
        fields = JOSE.JWT.to_map(jose_jwt) |> elem(1)
        {:ok, fields}

      _ ->
        {:ok, %{}}
    end
  end

  # TODO: etsにキャッシュする
  def get_cert(kid) do
    {:ok, %{body: body}} = HTTPoison.get(@cert_url)
    jwks = Poison.Parser.parse!(body, %{}) |> JOSE.JWK.from_firebase()
    jwks[kid] |> JOSE.JWK.to_map() |> elem(1)
  end
end
