defmodule PhoenixStarterWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use PhoenixStarterWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  alias PhoenixStarter.Accounts
  alias PhoenixStarterWeb.Auth
  use ExUnit.CaseTemplate

  @default_opts [
    store: :cookie,
    key: "secretkey",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt"
  ]
  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      alias PhoenixStarterWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint PhoenixStarterWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PhoenixStarter.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PhoenixStarter.Repo, {:shared, self()})
    end

    conn =
      Phoenix.ConnTest.build_conn()
      |> Plug.Session.call(@signing_opts)
      |> Plug.Conn.fetch_session()

    if tags[:authenticated] do
      {:ok, user} =
        Accounts.create_user(%{
          email: "some email",
          password: "some password",
          name: "some name"
        })

      {:ok, conn: Auth.Plug.sign_in(conn, user), user: user}
    else
      {:ok, conn: conn}
    end
  end
end
