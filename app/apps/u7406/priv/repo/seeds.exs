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
build_assoc(libgraph, :algorithms, %{name: "info"}) |> Repo.insert!(on_conflict: :nothing)
