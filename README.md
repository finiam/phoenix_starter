# PhoenixStarter

To start your Phoenix app:
  * Install dependencies and setup database with `bin/setup`
  * Start Phoenix and webpack with `bin/server`

To test and lint your app you can also do:
  * `bin/test` to run the Phoenix test suite
  * `bin/lint` to lint CSS, Javascript and Elixir code
  * `bin/ci` to replicate the CI pipeline, which runs all of the above.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Diferences to the classic template

`phx new` does a great job of a bootstrapping an Phoenix app for you, but we usually run things a little diference. This template has a few differences, mostly on the frontend side of things. We run all of our frontend code at the root of the project, mainly due to IDE and code editors limitations, that expect linters and configs to be at the root of the project. We also setup React which has been our SPA of choice nowadays.

Also, one of the most important changes is the usage of `wallaby` to make fullstack integration testing. So we can test the whole application.

## Frontend pipeline

We use Webpack to build the frontend assets. The entrypoint is `frontend/index.js`, currently this repo is configured to build a general purpose React app using PostCSS with CSS modules for styling. It also loads `jpg|png|webp|gif|mp4` files, inlining them if they are less than 5kb.

Files under `frontend` get transformed and outputted to `priv/static/assets`, which is where Phoenix expect static assets to be. Webpack processes every file through the entrypoint, so just organize files as you want. The only exception is the `frontend/static` folder. Files under that directory get copied as is to `priv/static`. Use that folder for favicons, robots files and any static file you need to host at the root of the app. WARNING: Don't forget to add those files to the `endpoint.ex` file under the `Plug.static` rule. Phoenix only serves a whitelist of those files.

## About

This starter kit is developed and maintained by Finiam.

Leave potential improvements and suggestions as issues on Github. Anything else reach us via [email](mailto:contact@finiam.com).
