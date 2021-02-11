defmodule PhoenixStarter.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias PhoenixStarter.Accounts
      alias PhoenixStarter.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import PhoenixStarterWeb.Router.Helpers
      import Wallaby.Query

      def sign_in(session, email, password \\ "foobar") do
        session
        |> visit("/login")
        |> fill_in(text_field("Email"), with: email)
        |> fill_in(text_field("Password"), with: "foobar")
        |> click(button("Submit"))
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PhoenixStarter.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PhoenixStarter.Repo, {:shared, self()})
    end

    metadata =
      Phoenix.Ecto.SQL.Sandbox.metadata_for(PhoenixStarter.Repo, self())

    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
