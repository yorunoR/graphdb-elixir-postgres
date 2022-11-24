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
alias U7406.Admin
alias U7406.Repo

user = Repo.insert!(%User{email: "sss.yoshioka@gmail.com", name: "yux", activated: true})
project = %Project{name: "Default Project", default: true} |> Repo.insert!()
build_assoc(user, :project_users, %{project: project, privilege: 0}) |> Repo.insert!()

Admin.register_admin_user(%{email: "sss.yoshioka@gmail.com", password: "123456"})
