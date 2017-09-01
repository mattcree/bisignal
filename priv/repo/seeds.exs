# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# It is also run when you use the command `mix ecto.setup`
#

users = [
  %{name: "Ted Bed", email: "ted@mail.com", password: "password"},
  %{name: "Ed Shed", email: "eddiebaby@mail.com", password: "password"},
  %{name: "Jerry Seinfeld", email: "seinfeld@mail.com", password: "password"},
  %{name: "Bob Saget", email: "seinfeld@mail.com", password: "password"}
]


for user <- users do
  {:ok, _} = Bisignal.Accounts.create_user(user)
end
