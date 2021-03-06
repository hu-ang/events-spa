# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Events.Repo.insert!(%Events.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Events.Repo
alias Events.Users.User
alice = Repo.insert!(%User{name: "alice", email: "alice", password_hash: ""})
bob = Repo.insert!(%User{name: "bob", email: "bob", password_hash: ""})
