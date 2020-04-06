#!/usr/bin/env node

/* eslint-disable no-console */

const webpack = require("webpack");
const WebpackDevServer = require("webpack-dev-server");
const config = require("./webpack.config");

new WebpackDevServer(webpack(config), config.devServer).listen(
  config.devServer.port,
  config.devServer.host,
  (err) => {
    if (err) console.error(err);
  }
);

process.stdin.resume();
process.stdin.on("end", () => {
  process.exit(0);
});
