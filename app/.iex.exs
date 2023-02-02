IO.puts("====-====-====-====-====")
IO.puts(".iex.exs")

IO.puts("* Import Modules")
import Ecto.Query
import U7406

IO.puts("* Alias Modules")
alias U7406.Repo
alias Schemas.Account.ApiKey
alias Schemas.Account.User
alias Schemas.Account.Project
alias Schemas.Calc.Agency
alias Schemas.Calc.Algorithm
alias Schemas.Graph.Tower
alias Schemas.Graph.Division
alias Schemas.Graph.Node
alias Schemas.Graph.NodeField
alias Schemas.Graph.NodeType
alias Schemas.Graph.Edge
alias Schemas.Graph.EdgeField
alias Schemas.Graph.EdgeType
alias Schemas.Graph.Rule
alias Schemas.Graph.SubGraphFilter
alias Schemas.Graph.Result
alias Schemas.Operation.NodesUpload
alias Schemas.Operation.EdgesUpload
alias Queries.AccountQuery
alias Queries.GraphQuery
alias Actions.Account.Mixin.ApiKeyFuncs.Crypt

IO.puts("====-====-====-====-====")
