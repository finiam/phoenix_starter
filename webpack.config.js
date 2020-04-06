const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const nodeEnv = process.env.NODE_ENV || "development";

module.exports = {
  optimization: {
    minimizer: [
      new TerserPlugin({ cache: true, parallel: true, sourceMap: false }),
    ],
  },
  entry: ["./frontend/index.js"],
  mode: nodeEnv,
  devtool: nodeEnv === "development" ? "source-map" : "none",
  output:
    nodeEnv === "production"
      ? {
          path: path.resolve(__dirname, "./priv/static"),
          filename: "./js/index.js",
          publicPath: "/",
        }
      : {
          path: path.resolve(__dirname, "./priv/static"),
          filename: "./js/index.js",
          publicPath: "http://localhost:8000/",
        },
  resolve: {
    alias: {
      root: path.resolve(__dirname, "./frontend/"),
      "react-dom": "@hot-loader/react-dom",
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
          {
            loader: MiniCssExtractPlugin.loader,
            options: {
              hmr: nodeEnv === "development",
            },
          },
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
              hmr: nodeEnv === "development",
            },
          },
          "css-loader",
          "postcss-loader",
        ],
      },
    ],
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: "./css/index.css" }),
    new CopyWebpackPlugin([{ from: "frontend/static/", to: "./" }]),
  ],
  devServer: {
    historyApiFallback: true,
    host: "0.0.0.0",
    port: 8000,
    hot: true,
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
    writeToDisk: (filePath) => {
      return /(favicon\.ico|texture.jpg|robots.txt|particle.png)$/.test(
        filePath
      );
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
