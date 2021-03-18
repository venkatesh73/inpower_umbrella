defmodule Database.Posts do
  @moduledoc """
  """
  import Ecto.Query

  alias Database.Repo
  alias Database.Schema.Post

  def create(params) do
    case Repo.insert(Post.changeset(params)) do
      {:ok, post} ->
        {:ok, post}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def lists() do
    query =
      from(p in "posts",
        where: p.active == true,
        select: map(p, [:id, :title, :context, :user_id, :group_id, :active])
      )

    Repo.all(query)
  end

  def get(post_id) do
    Repo.get_by(Post, id: post_id)
  end

  def get_posts_by_user(user_id) do
    query =
      from(p in "posts",
        where: p.user_id == ^user_id and p.active == true,
        select: map(p, [:id, :title, :context, :user_id, :group_id, :active])
      )

    Repo.all(query)
  end

  def get_posts_by_group(group_id) do
    query =
      from(p in "posts",
        where: p.group_id == ^group_id and p.active == true,
        select: map(p, [:id, :title, :context, :user_id, :group_id, :active])
      )

    Repo.all(query)
  end
end
