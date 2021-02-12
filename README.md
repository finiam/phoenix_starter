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

## Diferences to the `phx.new`

`phx new` does a great job of a bootstrapping a Phoenix app for you, but we usually run things a little different. This template has a few differences, mostly on the frontend side of things. We run all of our frontend code through `Snowpack` and that can be deployed as a standalone app. Here we serve the app at the `root` of the project, so `/`, and catching all fallback requests there, so client-side routing works. You can however, split it up entirely and serve the frontend at a different place.

Also, one of the most important changes is the usage of `wallaby` to make fullstack integration testing. So we can test the whole application. That's where the `PageController` acts, serving the `index.html` that snowpack produces during tests.

During development, you should use the build from the `snowpack` dev-server under port 8080. The frontend is automatically configured to use `localhost:4000` (phoenix endpoints) during dev, and `/` on testing and production.


## About

This starter kit is developed and maintained by Finiam.

Leave potential improvements and suggestions as issues on Github. Anything else reach us via [email](mailto:contact@finiam.com).
