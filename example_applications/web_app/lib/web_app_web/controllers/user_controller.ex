defmodule WebAppWeb.UserController do
  use WebAppWeb, :controller

  alias WebApp.Accounts

  def index(conn, _) do
    users = Accounts.list_users()
    json(conn, users)
  end

  def create(conn, params) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        json(conn, user)

      {:error, changeset} ->
        errors = errors_on(changeset)
        json(conn, errors)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    json(conn, user)
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.delete_user(id)
    json(conn, user)
  end

  def level_up(_conn, _params) do
  end

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
