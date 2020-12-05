defmodule WebApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :age, :integer
    field :first_name, :string
    field :last_name, :string
    field :points, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :age, :points])
    |> validate_required([:first_name, :last_name, :age, :points])
  end
end
