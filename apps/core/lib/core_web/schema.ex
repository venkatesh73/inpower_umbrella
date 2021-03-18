defmodule CoreWeb.Schema do
  use Absinthe.Schema

  alias CoreWeb.Resolvers.Post

  object :post do
    field(:id, non_null(:string))
    field(:title, non_null(:string))
    field(:context, non_null(:string))
    field(:active, non_null(:boolean))
    field(:user_id, non_null(:string))
    field(:group_id, non_null(:string))
  end

  query do
    @desc "Get a post by id"
    field :get, non_null(:post) do
      arg(:id, non_null(:string))
      resolve(&Post.get/3)
    end

    @desc "Get all the posts"
    field :posts, non_null(list_of(non_null(:post))) do
      resolve(&Post.get_posts/3)
    end

    @desc "Get post based on user id"
    field :user_posts, non_null(list_of(non_null(:post))) do
      arg(:user_id, non_null(:string))
      resolve(&Post.get_user_posts/3)
    end

    @desc "Get post based on Group id"
    field :group_posts, non_null(list_of(non_null(:post))) do
      arg(:group_id, non_null(:string))
      resolve(&Post.get_group_posts/3)
    end
  end

  mutation do
    @desc "Create a Post"
    field :create_post, :post do
      arg(:title, non_null(:string))
      arg(:context, non_null(:string))
      arg(:user_id, non_null(:string))
      arg(:group_id, non_null(:string))

      resolve(&Post.create_post/3)
    end
  end
end
