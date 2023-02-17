defmodule Queries.GraphQuery do
  import Ecto.Query

  def paginate(query, offset, limit) do
    query |> offset(^offset) |> limit(^limit) |> order_by(desc: :id)
  end

  def join_assocs(query, associations) when is_list(associations) do
    Enum.reduce(associations, query, fn association, query ->
      query |> join(:inner, [n], _ in assoc(n, ^association), as: ^association)
    end)
  end

  def join_bind_assocs(query, associations, bind_query) when is_list(associations) do
    Enum.reduce(associations, query, fn association, query ->
      column = :"#{association}_id"

      query
      |> join(:inner, [e], n in subquery(bind_query),
        on: field(e, ^column) == n.id,
        as: ^association
      )
    end)
  end

  def search(query, parameters) do
    next_operator = :and

    [query, _] =
      Enum.reduce(parameters, [query, next_operator], fn
        %{"key" => "operator", "value" => operator}, [query, _] ->
          next_operator =
            case operator do
              "+" -> :or
              "*" -> :and
              _ -> :and
            end

          [query, next_operator]

        %{"key" => key, "values" => values}, [query, next_operator] ->
          filter =
            case key do
              "nodeTypeUid" ->
                [:node_type, :uid]
                |> dynamic_condition(values, like: false)

              "edgeTypeUid" ->
                [:edge_type, :uid]
                |> dynamic_condition(values, like: false)

              "startNodeUid" ->
                [:start_node, :uid]
                |> dynamic_condition(values, like: false)

              "endNodeUid" ->
                [:end_node, :uid]
                |> dynamic_condition(values, like: false)

              "startNodeName" ->
                [:start_node, :name]
                |> dynamic_condition(values, like: true)

              "endNodeName" ->
                [:end_node, :name]
                |> dynamic_condition(values, like: true)

              "name" ->
                key
                |> String.to_existing_atom()
                |> dynamic_condition(values, like: true)

              _ ->
                key
                |> String.to_existing_atom()
                |> dynamic_condition(values, like: false)
            end

          query =
            case next_operator do
              :and -> query |> where(^filter)
              :or -> query |> or_where(^filter)
              _ -> query
            end

          [query, next_operator]
      end)

    query
  end

  def dynamic_condition([association, column], values, like: like_option) do
    connect_operator = :and

    [dynamic_filter, _connect_operator] =
      Enum.reduce(values, [dynamic(true), connect_operator], fn
        %{"type" => "term", "value" => value}, [dynamic, connect_operator] ->
          matcher = "%#{value}%"

          dynamic =
            case {like_option, connect_operator} do
              {true, :and} ->
                dynamic([{^association, n}], ^dynamic and like(field(n, ^column), ^matcher))

              {true, :or} ->
                dynamic([{^association, n}], ^dynamic or like(field(n, ^column), ^matcher))

              {false, :and} ->
                dynamic([{^association, n}], ^dynamic and field(n, ^column) == ^value)

              {false, :or} ->
                dynamic([{^association, n}], ^dynamic or field(n, ^column) == ^value)

              _ ->
                dynamic
            end

          [dynamic, connect_operator]

        %{"type" => "not_term", "value" => value}, [dynamic, connect_operator] ->
          matcher = "%#{value}%"

          dynamic =
            case {like_option, connect_operator} do
              {true, :and} ->
                dynamic([{^association, n}], ^dynamic and not like(field(n, ^column), ^matcher))

              {true, :or} ->
                dynamic([{^association, n}], ^dynamic or not like(field(n, ^column), ^matcher))

              {false, :and} ->
                dynamic([{^association, n}], ^dynamic and not field(n, ^column) == ^value)

              {false, :or} ->
                dynamic([{^association, n}], ^dynamic or not field(n, ^column) == ^value)

              _ ->
                dynamic
            end

          [dynamic, connect_operator]

        %{"type" => "operator", "value" => value}, [dynamic, _connect_operator] ->
          connect_operator =
            case value do
              "+" -> :or
              "*" -> :and
              _ -> :and
            end

          [dynamic, connect_operator]

        _, [dynamic, connect_operator] ->
          [dynamic, connect_operator]
      end)

    dynamic_filter
  end

  def dynamic_condition(column, values, like: like_option) do
    connect_operator = :and

    [dynamic_filter, _connect_operator] =
      Enum.reduce(values, [dynamic(true), connect_operator], fn
        %{"type" => "term", "value" => value}, [dynamic, connect_operator] ->
          matcher = "%#{value}%"

          dynamic =
            case {like_option, connect_operator} do
              {true, :and} -> dynamic([n], ^dynamic and like(field(n, ^column), ^matcher))
              {true, :or} -> dynamic([n], ^dynamic or like(field(n, ^column), ^matcher))
              {false, :and} -> dynamic([n], ^dynamic and field(n, ^column) == ^value)
              {false, :or} -> dynamic([n], ^dynamic or field(n, ^column) == ^value)
              _ -> dynamic
            end

          [dynamic, connect_operator]

        %{"type" => "not_term", "value" => value}, [dynamic, connect_operator] ->
          matcher = "%#{value}%"

          dynamic =
            case {like_option, connect_operator} do
              {true, :and} -> dynamic([n], ^dynamic and not like(field(n, ^column), ^matcher))
              {true, :or} -> dynamic([n], ^dynamic or not like(field(n, ^column), ^matcher))
              {false, :and} -> dynamic([n], ^dynamic and not field(n, ^column) == ^value)
              {false, :or} -> dynamic([n], ^dynamic or not field(n, ^column) == ^value)
              _ -> dynamic
            end

          [dynamic, connect_operator]

        %{"type" => "operator", "value" => value}, [dynamic, _connect_operator] ->
          connect_operator =
            case value do
              "+" -> :or
              "*" -> :and
              _ -> :and
            end

          [dynamic, connect_operator]

        _, [dynamic, connect_operator] ->
          [dynamic, connect_operator]
      end)

    dynamic_filter
  end
end
