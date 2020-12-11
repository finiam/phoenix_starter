/* eslint-disable global-require, import/no-extraneous-dependencies */

module.exports = {
  plugins: [
    process.env.NODE_ENV === "production" ? require("autoprefixer")() : null,
    require("postcss-custom-media")({
      importFrom: [__dirname + "/src/styles/breakpoints.css"],
    }),
    require("postcss-nested"),
    process.env.NODE_ENV === "production"
      ? require("cssnano")({
          preset: "default",
        })
      : null,
  ],
};
