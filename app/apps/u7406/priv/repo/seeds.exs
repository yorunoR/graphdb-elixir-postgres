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

alias Schemas.Account.User
alias U7406.Admin
alias U7406.Repo

Repo.insert!(%User{email: "sss.yoshioka@gmail.com", name: "yux", activated: true})
Admin.register_admin_user(%{email: "sss.yoshioka@gmail.com", password: "123456"})
