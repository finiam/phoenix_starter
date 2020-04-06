/*
  The order of the plugins in this file is very important.
  postcss-import should be at beggining so @import statements
  get processed first.
  cssnano should always be at the bottom, as it's the last thing
  that should run over our CSS
  The rest is hit or miss, check each plugin documentation
  for potential interactions with other plugins
*/

module.exports = {
  plugins: [
    require("postcss-import"),
    require("precss"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009"
      },
      stage: 3
    }),
    process.env.NODE_ENV === "production"
      ? require("cssnano")({
          preset: "default"
        })
      : null
  ]
};