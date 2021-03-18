defmodule InpowerProto.PostResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary,
          title: String.t(),
          context: String.t(),
          active: boolean,
          user_id: String.t(),
          group_id: String.t()
        }

  defstruct [:id, :title, :context, :active, :user_id, :group_id]

  field(:id, 1, type: :bytes)
  field(:title, 2, type: :string)
  field(:context, 3, type: :string)
  field(:active, 4, type: :bool)
  field(:user_id, 5, type: :string)
  field(:group_id, 6, type: :string)
end

defmodule InpowerProto.CreatePost do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          title: String.t(),
          context: String.t(),
          user_id: String.t(),
          group_id: String.t()
        }

  defstruct [:title, :context, :user_id, :group_id]

  field(:title, 1, type: :string)
  field(:context, 2, type: :string)
  field(:user_id, 3, type: :string)
  field(:group_id, 4, type: :string)
end

defmodule InpowerProto.GetPost do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t()
        }

  defstruct [:id]

  field(:id, 1, type: :string)
end

defmodule InpowerProto.GetPosts do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule InpowerProto.GetGroupPosts do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          group_id: String.t()
        }

  defstruct [:group_id]

  field(:group_id, 1, type: :string)
end

defmodule InpowerProto.GetUsersPosts do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          user_id: String.t()
        }

  defstruct [:user_id]

  field(:user_id, 1, type: :string)
end

defmodule InpowerProto.ListResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          posts: [InpowerProto.PostResponse.t()]
        }

  defstruct [:posts]

  field(:posts, 1, repeated: true, type: InpowerProto.PostResponse)
end

defmodule InpowerProto.Post.Service do
  @moduledoc false
  use GRPC.Service, name: "inpower_proto.Post"

  rpc(:Create, InpowerProto.CreatePost, InpowerProto.PostResponse)

  rpc(:Get, InpowerProto.GetPost, InpowerProto.PostResponse)

  rpc(:List, InpowerProto.GetPosts, InpowerProto.ListResponse)

  rpc(:GroupList, InpowerProto.GetGroupPosts, InpowerProto.ListResponse)

  rpc(:UsersList, InpowerProto.GetUsersPosts, InpowerProto.ListResponse)
end

defmodule InpowerProto.Post.Stub do
  @moduledoc false
  use GRPC.Stub, service: InpowerProto.Post.Service
end
