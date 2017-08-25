# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# It is also run when you use the command `mix ecto.setup`
#

users = [
  %{name: "Ted Bed", bio: "Just a man on a bike", email: "ted@mail.com", password: "password"},
  %{name: "Ed Shed", bio: "Just bike man", email: "eddiebaby@mail.com", password: "password"}
]

for user <- users do
  {:ok, _} = Bisignal.Accounts.create_user(user)
end
