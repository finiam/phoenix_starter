# Updating runtimes

This project uses `Erlang`, `Elixir` and `Javascript` (NodeJS). We should keep these updated often, to reduce vulnerabilities and keep the project in tip top shape.

To update, simply alter the versions in the following files:
- `.github/workflows/ci.yml` - just `Erlang` and `Elixir`
- `.tool-version` - this is used `asdf-vm` which we recommend everyone uses
- `elixir_buildpack.config` - this is for the `Heroku` buildpack config

Open a PR and make sure all tests pass and the Heroku review app deploys with ease. If everything is ok, it should be ready to merge.
