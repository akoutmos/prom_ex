# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WebApp.Repo.insert!(%WebApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Faker.start()

if length(WebApp.Accounts.list_users()) < 100 do
  1..1000
  |> Enum.each(fn _ ->
    first_name = Faker.Person.first_name()
    last_name = Faker.Person.last_name()
    age = Faker.random_between(18, 75)

    WebApp.Accounts.create_user(%{
      age: age,
      first_name: first_name,
      last_name: last_name,
      points: 0
    })
  end)
end
