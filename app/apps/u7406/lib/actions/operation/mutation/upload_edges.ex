defmodule Actions.Operation.Mutation.UploadEdges do
  import Ecto.Changeset
  import U7406

  alias Ecto.Multi
  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.Edge
  alias Schemas.Graph.Node
  alias Schemas.Operation.EdgesUpload
  alias U7406.Repo

  @max_range 1_000_000

  def run(_parent, args, _context) do
    %{"files" => files, "edge_type_id" => id} = args
    edge_type = Repo.get(EdgeType, id)

    edges_uploads =
      files
      |> Enum.map(fn file ->
        %{
          name: file.filename,
          content_type: file.content_type,
          object_path: file.path
        }
      end)
      |> Enum.map(fn attrs ->
        build_assoc(edge_type, :edges_uploads)
        |> create_edges_upload_changeset(attrs)
        |> Repo.insert!()
      end)

    edges_uploads
    |> Enum.each(fn edges_upload ->
      File.stream!(edges_upload.object_path)
      |> CSV.decode!(headers: true)
      |> Enum.each(fn %{"skip" => skip} = line ->
        case String.trim(skip) == "" do
          true ->
            name = line["name"]
            props = Map.drop(line, ["skip", "start_node_uid", "end_node_uid", "name"])

            start_node = Repo.get_by!(Node, uid: line["start_node_uid"])
            end_node = Repo.get_by!(Node, uid: line["end_node_uid"])

            random =
              Stream.repeatedly(fn -> :rand.uniform(@max_range) end)
              |> Enum.find(fn random -> Repo.get_by(Edge, random: random) == nil end)

            Multi.new()
            |> Multi.run(
              :check_rule,
              &Edge.Create.check_rule(&1, &2, edge_type, start_node, end_node)
            )
            |> Multi.run(
              :create_edge,
              &Edge.Create.create_edge(&1, &2, start_node, end_node, name, random, props)
            )
            |> Multi.run(
              :connect_edge,
              &Edge.Create.connect_edge(&1, &2, edge_type, start_node, end_node)
            )
            |> Repo.transaction()
            |> transaction_result()

          _ ->
            nil
        end
      end)
    end)

    {:ok, edges_uploads}
  end

  def create_edges_upload_changeset(
        %EdgesUpload{} = edges_upload,
        attrs
      ) do
    edges_upload
    |> cast(attrs, [:name, :content_type, :object_path])
    |> validate_required([:name, :content_type, :object_path])
  end

  def transaction_result({:ok, %{connect_edge: edge}}) do
    {:ok, edge}
  end

  def transaction_result({:error, _operation, error, _successes}) do
    {:error, error}
  end
end
