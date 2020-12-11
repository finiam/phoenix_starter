module.exports = {
  mount: {
    src: "/assets",
    static: "/",
  },

  plugins: [
    "@snowpack/plugin-postcss",

    "@snowpack/plugin-react-refresh",

    "@snowpack/plugin-typescript",

    "@snowpack/plugin-dotenv",

    [
      "@snowpack/plugin-webpack",
      {
        extendConfig: (config) => ({
          ...config,
          optimization: {
            ...config.optimization,

            splitChunks: {
              chunks: "all",
            },
          },
        }),
      },
    ],
  ],

  devOptions: {
    open: "none",
    output: "stream",
  },

  alias: {
    root: "./src",
  },
};
