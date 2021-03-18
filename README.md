# Inpower.Umbrella
update `.env` DB creds and run `source .env`

run `mix deps.get` inside the apps one in core and another one in database (Globally there is Cyclic deps issue)

If you get any issue in installing deps run this below code
    `mix deps.unlock --all`
    `mix deps.update --all`

Then run `mix grpc.server` in one tab and `mix phx.server` in another tab.

To make it simple I have add GraphQL for accessing the API 

`http://localhost:4000/graphiql`
