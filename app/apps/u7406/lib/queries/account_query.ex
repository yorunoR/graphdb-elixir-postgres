defmodule Queries.AccountQuery do
  import Ecto.Query

  def default_projects(projects_query) do
    projects_query
    |> where([p], p.default == true)
  end
end
