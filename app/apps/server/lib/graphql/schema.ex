defmodule Graphql.Schema do
  use Absinthe.Schema

  alias Graphql.Middlewares.ErrorHandler
  alias Graphql.Middlewares.SafeResolution
  alias Graphql.Sources.Db
  alias Graphql.Types.CommonType
  alias Graphql.Types.AccountType
  alias Graphql.Types.GraphType
  alias Graphql.Types.InputObject
  alias Graphql.Types.CustomObject
  alias Graphql.Types.ResourceObject

  import_types(Absinthe.Type.Custom)
  import_types(CommonType)
  import_types(AccountType)
  import_types(GraphType)
  import_types(InputObject.InputItem)
  import_types(InputObject.InputSelections)
  import_types(InputObject.InputApiKey)
  import_types(InputObject.InputProject)
  import_types(InputObject.InputTower)
  import_types(InputObject.InputDivision)
  import_types(InputObject.InputNode)
  import_types(InputObject.InputNodeType)
  import_types(InputObject.InputNodeField)
  import_types(InputObject.InputEdge)
  import_types(InputObject.InputEdgeType)
  import_types(InputObject.InputEdgeField)
  import_types(InputObject.InputRule)
  import_types(InputObject.InputSubGraphFilter)
  import_types(CustomObject.Item)
  import_types(CustomObject.Status)
  import_types(CustomObject.DivisionList)
  import_types(CustomObject.EdgeList)
  import_types(CustomObject.NodeList)
  import_types(CustomObject.Pagination)
  import_types(CustomObject.GraphStatus)
  import_types(ResourceObject.ApiKey)
  import_types(ResourceObject.Project)
  import_types(ResourceObject.Tower)
  import_types(ResourceObject.Division)
  import_types(ResourceObject.Node)
  import_types(ResourceObject.NodeType)
  import_types(ResourceObject.NodeField)
  import_types(ResourceObject.Edge)
  import_types(ResourceObject.EdgeType)
  import_types(ResourceObject.EdgeField)
  import_types(ResourceObject.Rule)
  import_types(ResourceObject.SubGraphFilter)
  import_types(ResourceObject.Result)
  import_types(ResourceObject.User)

  query do
    import_fields(:common_queries)
    import_fields(:account_queries)
    import_fields(:graph_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:graph_mutations)
  end

  subscription do
    import_fields(:account_subscriptions)
  end

  def context(ctx) do
    loader = Dataloader.new() |> Dataloader.add_source(:db, Db.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middlewares, _field, %{identifier: type}) when type in [:query, :mutation] do
    SafeResolution.apply(middlewares) ++ [ErrorHandler]
  end

  def middleware(middlewares, _field, _object) do
    middlewares
  end
end
