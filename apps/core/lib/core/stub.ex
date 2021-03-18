defmodule Core.Stub do
  @moduledoc """
  """

  alias InpowerProto.Post.Stub

  alias InpowerProto.{
    PostResponse,
    CreatePost,
    GetPost,
    GetPosts,
    GetGroupPosts,
    GetUsersPosts,
    ListResponse
  }

  @inpower_database_url "localhost:8080"

  def get_posts() do
    with {:ok, channel} <- GRPC.Stub.connect(@inpower_database_url),
         {:ok, %ListResponse{} = response} <- Stub.list(channel, GetPosts.new()) do
      response
    end
  end

  def create_post(params) do
    with {:ok, channel} <- GRPC.Stub.connect(@inpower_database_url),
         {:ok, data} <- build_params(params),
         {:ok, %GetPost{} = response} <- Stub.create(channel, data) do
      response
    end
  end

  def get_post(post_id) do
    with {:ok, channel} <- GRPC.Stub.connect(@inpower_database_url),
         {:ok, %GetPost{} = response} <- Stub.get(channel, GetPost.new(id: post_id)) do
      response
    end
  end

  def get_group_posts(group_id) do
    with {:ok, channel} <- GRPC.Stub.connect(@inpower_database_url),
         {:ok, %ListResponse{} = response} <- Stub.group_list(channel, GetGroupPosts.new(group_id: group_id)) do
      response
    end
  end

  def get_users_posts(user_id) do
    with {:ok, channel} <- GRPC.Stub.connect(@inpower_database_url),
         {:ok, %ListResponse{} = response} <- Stub.users_list(channel, GetUsersPosts.new(user_id: user_id)) do
      response
    end
  end

  def build_params(%{context: context, group_id: group_id, title: title, user_id: user_id}),
    do:
      {:ok,
       CreatePost.new(
         title: title,
         context: context,
         user_id: user_id,
         group_id: group_id
       )}
end
