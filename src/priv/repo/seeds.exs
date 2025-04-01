# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Acorte.Repo.insert!(%Acorte.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Acorte.Repo
alias Acorte.Accounts.User

user_params = %{
  email: "admin@acorte.com",
  password: "123"
}

%User{}
|> User.changeset(user_params)
|> Repo.insert!()
