defmodule Database.Endpoint do
  use GRPC.Endpoint

  intercept(GRPC.Logger.Server)
  run(Database.InpowerService.Server)
end
