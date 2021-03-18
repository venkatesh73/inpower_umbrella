defmodule Database.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :context, :string
      add :user_id, :string
      add :group_id, :string
      add :active, :boolean, default: true

      timestamps()
    end
  end
end
