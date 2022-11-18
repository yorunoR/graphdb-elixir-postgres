defmodule Server.UploadView do
  use Server, :view

  alias Server.UploadView

  def render("nodes.json", %{nodes_uploads: nodes_uploads}) do
    %{data: render_many(nodes_uploads, UploadView, "upload.json")}
  end

  def render("edges.json", %{edges_uploads: edges_uploads}) do
    %{data: render_many(edges_uploads, UploadView, "upload.json")}
  end

  def render("upload.json", %{upload: upload}) do
    %{
      id: upload.id
    }
  end
end
