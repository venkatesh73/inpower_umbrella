defmodule Database.InpowerService.Server do
  @moduledoc """
  """
  use GRPC.Server, service: InpowerProto.Post.Service

  alias InpowerProto.{
    PostResponse,
    CreatePost,
    GetPost,
    GetPosts,
    ListResponse,
    GetGroupPosts,
    GetUsersPosts
  }

  require Logger

  def create(
        %CreatePost{
          context: context,
          group_id: group_id,
          title: title,
          user_id: user_id
        },
        _stream
      ) do
    case Database.Posts.create(%{
           "context" => context,
           "group_id" => group_id,
           "title" => title,
           "user_id" => user_id
         }) do
      {:ok, post} ->
        post
        |> Map.from_struct()
        |> PostResponse.new()

      {:error, _message} ->
        PostResponse.new()
    end
  end

  def list(%GetPosts{}, _stream) do
    posts = Database.Posts.lists()
    ListResponse.new(posts: posts)
  end

  def get(%GetPost{id: id}, _stream) do
    id
    |> Database.Posts.get()
    |> Map.from_struct()
    |> Map.drop([:__meta__])
    |> PostResponse.new()
  end

  def group_list(%GetGroupPosts{group_id: group_id}, _stream) do
    posts = Database.Posts.get_posts_by_group(group_id)
    ListResponse.new(posts: posts)
  end

  def users_list(%GetUsersPosts{user_id: user_id}, _stream) do
    posts = Database.Posts.get_posts_by_user(user_id)
    ListResponse.new(posts: posts)
  end
end
