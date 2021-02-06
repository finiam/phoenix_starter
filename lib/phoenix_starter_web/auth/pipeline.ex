defmodule PhoenixStarterWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :phoenix_starter

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug PhoenixStarterWeb.Auth.CurrentUser
end
