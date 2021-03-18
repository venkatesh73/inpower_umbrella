defmodule Database.Schema.Post do
  @moduledoc """
  Inpower applications post schema
  """
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "posts" do
    field(:title, :string)
    field(:context, :string)
    field(:user_id, :string)
    field(:group_id, :string)
    field(:active, :boolean, default: true)

    timestamps()
  end

  def changeset(attrs \\ %{}) do
    %__MODULE__{}
    |> cast(attrs, [:title, :context, :user_id, :group_id, :active])
    |> validate_required([:title, :context, :user_id])
  end
end
