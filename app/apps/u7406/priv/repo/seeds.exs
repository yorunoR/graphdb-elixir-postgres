# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     U7406.Repo.insert!(%U7406.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import U7406

alias Schemas.Account.Project
alias Schemas.Account.User
alias Schemas.Calc.Agency
alias U7406.Admin
alias U7406.Repo

admin_params = %{email: "kimisato.industries@gmail.com", name: "Anonymous admin", activated: true}
admin = struct(User, admin_params) |> Repo.insert!(on_conflict: :nothing)

anonymous_project_params = %{
  name: "Anonymous Project",
  default: true,
  project_key: "---ThisIsAnAnonymousProject.----"
}

anonymous_project =
  struct(Project, anonymous_project_params) |> Repo.insert!(on_conflict: :nothing)

anonymous_project =
  if anonymous_project.id == nil,
    do: Repo.get_by!(Project, anonymous_project_params),
    else: anonymous_project

build_assoc(admin, :project_users, %{project: anonymous_project, privilege: 0})
|> Repo.insert!(on_conflict: :nothing)

user_params = %{email: "sss.yoshioka@gmail.com", name: "yux", activated: true}
user = struct(User, user_params) |> Repo.insert!(on_conflict: :nothing)
user = if user.id == nil, do: Repo.get_by!(User, user_params), else: user

project_params = %{
  name: "Default Project",
  default: true,
  project_key: "mUUNjAjhrqrGVIrprI1eh07nTo+hyWWK"
}

project = struct(Project, project_params) |> Repo.insert!(on_conflict: :nothing)
project = if project.id == nil, do: Repo.get_by!(Project, project_params), else: project

build_assoc(user, :project_users, %{project: project, privilege: 0})
|> Repo.insert!(on_conflict: :nothing)

Admin.register_admin_user(%{email: "sss.yoshioka@gmail.com", password: "123456"})

libgraph_params = %{name: "Libgraph"}
libgraph = struct(Agency, libgraph_params) |> Repo.insert!(on_conflict: :nothing)
libgraph = if libgraph.id == nil, do: Repo.get_by!(Agency, libgraph_params), else: libgraph

build_assoc(libgraph, :algorithms, %{name: "info", arity: 0, description: "概要取得"})
|> Repo.insert!(on_conflict: :nothing)

build_assoc(libgraph, :algorithms, %{
  name: "get_shortest_path",
  arity: 2,
  description: "第一引数：始点のUID\n第二引数：終点のUID",
  drawable: true
})
|> Repo.insert!(on_conflict: :nothing)

sub_graph_params = %{name: "SubGraph"}
sub_graph = struct(Agency, sub_graph_params) |> Repo.insert!(on_conflict: :nothing)
sub_graph = if sub_graph.id == nil, do: Repo.get_by!(Agency, sub_graph_params), else: sub_graph

build_assoc(sub_graph, :algorithms, %{name: "node_count", arity: 0, description: "ノード数"})
|> Repo.insert!(on_conflict: :nothing)

build_assoc(sub_graph, :algorithms, %{name: "edge_count", arity: 0, description: "エッジ数"})
|> Repo.insert!(on_conflict: :nothing)
