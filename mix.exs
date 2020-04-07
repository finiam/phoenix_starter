defmodule PhoenixStarter.MixProject do
  use Mix.Project

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
      {:credo, "~> 1.1.4", [runtime: false, only: :dev]},
      {:phoenix, "~> 1.4.16"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:wallaby, "~> 0.23.0", [runtime: false, only: :test]}
    ]
  end

  defp aliases do
    [
      "assets.build": &compile_assets/1,
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: [
        "assets.build --silent",
        "ecto.create --quiet",
        "ecto.migrate",
        "test"
      ]
    ]
  end

  defp compile_assets(_) do
    Mix.shell().cmd("yarn build")
  end
end
