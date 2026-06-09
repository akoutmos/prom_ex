[host] = System.argv()
pools = Map.put(%{}, host, size: 32, count: 8)

Finch.start_link(name: StressTester, pools: pools)

users_path = "#{host}/users"

level_up_user = fn id ->
  "#{host}/users/#{id}/action/level-up"
end

get_user = fn id ->
  "#{host}/users/#{id}"
end

# Get all of the users on the system
{:ok, %Finch.Response{body: body}} =
  :get
  |> Finch.build(users_path)
  |> Finch.request(StressTester)

all_users = PromEx.JSON.decode!(body)

# Level up all the users slowly
all_users
|> Task.async_stream(
  fn user ->
    path = level_up_user.(user["id"])

    :post
    |> Finch.build(path)
    |> Finch.request(StressTester)
  end,
  max_concurrency: 1
)
|> Stream.run()

# Level up all users a little more quickly
all_users
|> Task.async_stream(
  fn user ->
    path = level_up_user.(user["id"])

    :post
    |> Finch.build(path)
    |> Finch.request(StressTester)
  end,
  max_concurrency: 5
)
|> Stream.run()

# Fetch each individual user at the same time that new users are being created
task_1 =
  Task.async(fn ->
    all_users
    |> Enum.shuffle()
    |> Task.async_stream(
      fn user ->
        path = get_user.(user["id"])

        :get
        |> Finch.build(path)
        |> Finch.request(StressTester)
      end,
      max_concurrency: 5
    )
    |> Stream.run()
  end)

task_2 =
  Task.async(fn ->
    1..500
    |> Enum.shuffle()
    |> Task.async_stream(
      fn _ ->
        first_name = Faker.Person.first_name()
        last_name = Faker.Person.last_name()
        age = Faker.random_between(18, 75)

        data = %{first_name: first_name, last_name: last_name, age: age, points: 0}
        payload = PromEx.JSON.encode!(data)

        :post
        |> Finch.build(users_path, [{"content-type", "application/json"}], payload)
        |> Finch.request(StressTester)
      end,
      max_concurrency: 5
    )
    |> Stream.run()
  end)

Task.await_many([task_1, task_2], 60_000)

# Delete some users
# Get all of the users on the system
{:ok, %Finch.Response{body: body}} =
  :get
  |> Finch.build(users_path)
  |> Finch.request(StressTester)

all_users = PromEx.JSON.decode!(body)

all_users
|> Enum.shuffle()
|> Enum.take(500)
|> Task.async_stream(
  fn user ->
    path = get_user.(user["id"])

    :delete
    |> Finch.build(path)
    |> Finch.request(StressTester)
  end,
  max_concurrency: 5
)
|> Stream.run()
