const path = require("path");
const fs = require("fs");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const ReactRefreshWebpackPlugin = require("@pmmmwh/react-refresh-webpack-plugin");

const isDev = process.env.NODE_ENV !== "production";

module.exports = {
  entry: ["./frontend/index.js"],
  mode: isDev ? "development" : "production",
  devtool: isDev ? "source-map" : "none",
  output: isDev
    ? {
        path: path.resolve(__dirname, "./priv/static/assets"),
        filename: "./index.js",
        publicPath: "http://localhost:8000/assets/",
      }
    : {
        path: path.resolve(__dirname, "./priv/static/assets"),
        filename: "./index.js",
        publicPath: "/assets/",
      },
  resolve: {
    alias: {
      root: path.resolve(__dirname, "./frontend/"),
    },
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /module\.(css|scss)$/,
        use: [
          isDev ? "style-loader" : MiniCssExtractPlugin.loader,
          {
            loader: "css-loader",
            options: {
              modules: {
                mode: "local",
                localIdentName: "[folder]__[local]--[hash:base64:5]",
              },
            },
          },
          "postcss-loader",
        ],
      },
      {
        test: /\.(css|scss)$/,
        exclude: /\.module\.(css|scss)$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {
              hmr: isDev,
            },
          },
          "css-loader",
          "postcss-loader",
        ],
      },
      {
        test: /\.(jpg|png|webp|gif|mp4)$/,
        use: {
          loader: "url-loader",
          options: {
            limit: 5000,
          },
        },
      },
    ],
  },
  plugins: [
    new ReactRefreshWebpackPlugin(),
    new MiniCssExtractPlugin({ filename: "./index.css" }),
    new CopyWebpackPlugin({
      patterns: [{ from: "frontend/static/", to: "../" }],
    }),
  ],
  devServer: {
    publicPath: "/assets/",
    historyApiFallback: true,
    host: "0.0.0.0",
    port: 8000,
    hot: true,
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
    writeToDisk: (incomingFilePath) => {
      const filesToWrite = fs.readdirSync("frontend/static");

      return filesToWrite.some((file) => incomingFilePath.endsWith(file));
    },
    /* eslint-disable */
    before: function (app, webpackServer) {
      // We override the listen() function to set keepAliveTimeout.
      // See: https://github.com/microsoft/WSL/issues/4340
      // Original listen(): https://github.com/webpack/webpack-dev-server/blob/f80e2ae101e25985f0d7e3e9af36c307bfc163d2/lib/Server.js#L744
      const { listen } = webpackServer;
      webpackServer.listen = function (...args) {
        const server = listen.call(this, ...args);
        server.keepAliveTimeout = 0;
        return server;
      };
    },
    /* eslint-enable */
  },
};
