defmodule Actions.Operation.Mutation.UploadNodes do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.Node
  alias Schemas.Graph.NodeType
  alias Schemas.Operation.NodesUpload
  alias U7406.Repo

  @max_range 1_000_000

  def run(_parent, args, _context) do
    %{"files" => files, "node_type_id" => id} = args
    node_type = Repo.get(NodeType, id)

    nodes_uploads =
      files
      |> Enum.map(fn file ->
        %{
          name: file.filename,
          content_type: file.content_type,
          object_path: file.path
        }
      end)
      |> Enum.map(fn attrs ->
        build_assoc(node_type, :nodes_uploads)
        |> create_nodes_upload_changeset(attrs)
        |> Repo.insert!()
      end)

    nodes_uploads
    |> Enum.each(fn nodes_upload ->
      File.stream!(nodes_upload.object_path)
      |> CSV.decode!(headers: true)
      |> Enum.each(fn %{"skip" => skip} = line ->
        case String.trim(skip) == "" do
          true ->
            props = Map.drop(line, ["skip", "uid", "name"])

            random = :rand.uniform(@max_range)

            build_assoc(node_type, :nodes)
            |> upload_node_changeset(
              %{uid: line["uid"], name: line["name"], random: random},
              props
            )
            |> Repo.insert!()

          _ ->
            nil
        end
      end)
    end)

    {:ok, nodes_uploads}
  end

  def create_nodes_upload_changeset(
        %NodesUpload{} = nodes_upload,
        attrs
      ) do
    nodes_upload
    |> cast(attrs, [:name, :content_type, :object_path])
    |> validate_required([:name, :content_type, :object_path])
  end

  def upload_node_changeset(%Node{} = node, attrs, props) do
    node
    |> cast(attrs, [:name, :uid, :random])
    |> validate_required([:name, :uid, :random])
    |> unique_constraint([:divieion_id, :uid], name: :nodes_uid_uniq_index)
    |> unique_constraint([:divieion_id, :random], name: :nodes_random_uniq_index)
    |> put_change(:props, props)
  end
end
