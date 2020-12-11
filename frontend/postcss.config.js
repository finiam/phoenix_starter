/* eslint-disable global-require, import/no-extraneous-dependencies */
const path = require("path");

module.exports = {
  plugins: [
    process.env.NODE_ENV === "production" ? require("autoprefixer")() : null,
    require("postcss-custom-media")({
      importFrom: [path.join(__dirname, "/src/styles/breakpoints.css")],
    }),
    require("postcss-nested"),
    process.env.NODE_ENV === "production"
      ? require("cssnano")({
          preset: "default",
        })
      : null,
  ],
};
