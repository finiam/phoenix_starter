# PhoenixStarter

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `yarn`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Frontend pipeline

We use Webpack to build the frontend assets. The entrypoint is `frontend/index.js`, currently this repo is configured to build a general purpose React app using PostCSS with CSS modules for styling. It also loads `jpg|png|webp|gif|mp4` files, inlining them if they are less than 5kb.

Files under `frontend` get transformed and outputted to `priv/static/assets`, which is where Phoenix expect static assets to be. Webpack processes every file through the entrypoint, so just organize files as you want. The only exception is the `frontend/static` folder. Files under that directory get copied as is to `priv/static`. Use that folder for favicons, robots files and any static file you need to host at the root of the app. WARNING: Don't forget to add those files to the `endpoint.ex` file under the `Plug.static` rule. Phoenix only serves a whitelist of those files.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
