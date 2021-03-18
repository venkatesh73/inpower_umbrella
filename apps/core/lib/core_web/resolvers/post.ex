defmodule CoreWeb.Resolvers.Post do
  @moduledoc """
  GraphQL Resolver for Users post Module
  """
  alias Core.Stub

  @spec get(any(), any(), any()) :: map()
  def get(_root, %{id: post_id}, _info) do
    Stub.get_post(post_id)
  end

  def get_user_posts(_root, %{user_id: user_id}, _info) do
    {:ok, Stub.get_users_posts(user_id).posts}
  end

  def get_group_posts(_root, %{group_id: group_id}, _info) do
    {:ok, Stub.get_group_posts(group_id).posts}
  end

  def get_posts(_root, _args, _info) do
    {:ok, Stub.get_posts().posts}
  end

  def create_post(_root, args, _info) do
    case Stub.create_post(args) do
      post ->
        post

      _ ->
        {:error, "could not create post"}
    end
  end
end
