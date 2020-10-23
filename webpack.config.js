const path = require("path");
const fs = require("fs");
const webpack = require("webpack");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const ReactRefreshWebpackPlugin = require("@pmmmwh/react-refresh-webpack-plugin");

const isDev = process.env.NODE_ENV !== "production";

module.exports = {
  entry: ["./frontend/index.js"],
  // Check https://github.com/webpack/webpack-dev-server/issues/2758
  target: isDev ? "web" : "browserslist",
  mode: isDev ? "development" : "production",
  devtool: isDev ? "eval-source-map" : undefined,
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
    isDev ? new webpack.HotModuleReplacementPlugin() : null,
    isDev
      ? new ReactRefreshWebpackPlugin({
          overlay: { sockPort: 8000 },
        })
      : null,
    new MiniCssExtractPlugin({ filename: "./index.css" }),
    new CopyWebpackPlugin({
      patterns: [{ from: "frontend/static/", to: "../" }],
    }),
  ].filter((plugin) => !!plugin),
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
  },
};
