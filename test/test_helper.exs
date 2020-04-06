ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(PhoenixStarter.Repo, :manual)
Application.put_env(:wallaby, :base_url, PhoenixStarterWeb.Endpoint.url())
{:ok, _apps} = Application.ensure_all_started(:wallaby)
