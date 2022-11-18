defmodule Server.UploadController do
  use Server, :controller

  alias Resolvers.OperationResolver

  action_fallback Server.FallbackController

  def nodes(%{assigns: assigns} = conn, params) do
    with {:ok, nodes_uploads} <- OperationResolver.call(:upload_nodes, nil, params, assigns) do
      render(conn, "nodes.json", nodes_uploads: nodes_uploads)
    end
  end

  def edges(%{assigns: assigns} = conn, params) do
    with {:ok, edges_uploads} <- OperationResolver.call(:upload_edges, nil, params, assigns) do
      render(conn, "edges.json", edges_uploads: edges_uploads)
    end
  end
end
