defmodule PhoenixStarter.MixProject do
  use Mix.Project

  @env Mix.env()

  def project do
    [
      app: :phoenix_starter,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {PhoenixStarter.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.4.16"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"}
      | deps(@env)
    ]
  end

  defp deps(env) when env in [:dev, :text] do
    [
      {:credo, "~> 1.4.0", runtime: false},
      {:phoenix_live_reload, "~> 1.2"},
      {:wallaby, "~> 0.24.0", runtime: false}
    ]
  end

  defp deps(_), do: []

  defp aliases do
    [
      "assets.build": &compile_assets/1,
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: [
        "assets.build",
        "ecto.create --quiet",
        "ecto.migrate",
        "test"
      ]
    ]
  end

  defp compile_assets(_) do
    Mix.shell().cmd("yarn build --silent")
  end
end
