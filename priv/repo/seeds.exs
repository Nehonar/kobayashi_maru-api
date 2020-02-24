# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     KobayashiMaru.Repo.insert!(%KobayashiMaru.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

user =
  KobayashiMaru.Accounts.User.registration_changeset(%KobayashiMaru.Accounts.User{}, %{
    name: "some user",
    email: "user@kobayashiMaru",
    password: "user@kobayashiMaru"
  })

  KobayashiMaru.Repo.insert!(user)
