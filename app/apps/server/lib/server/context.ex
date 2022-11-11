defmodule Server.Context do
  require Logger

  import Plug.Conn

  alias Actions.Account.Query.UserAndProject

  @cert_url "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com"

  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{"email" => email, "user_id" => uid, "name" => name}} <- verify(token),
         [project_id] <- get_req_header(conn, "cid") do
      {:ok, {current_user, current_project}} =
        get_user_and_project(uid, String.to_integer(project_id))

      %{
        current_user: current_user,
        email: email,
        uid: uid,
        name: name,
        current_project: current_project
      }
    else
      err ->
        err |> inspect |> Logger.error()
        %{}
    end
  end

  def get_user_and_project(nil, _) do
    {:ok, {nil, nil}}
  end

  def get_user_and_project(uid, nil) do
    get_user_and_project(uid, 0)
  end

  def get_user_and_project(uid, project_id) do
    UserAndProject.run(nil, %{uid: uid, project_id: project_id}, %{})
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
