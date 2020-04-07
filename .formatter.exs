[
  import_deps: [:ecto, :phoenix],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"],
  line_length: 80,
  locals_without_parens: [
    # elixir
    defstruct: :*,
    defmodule: :*,
    send: :*,
    spawn: :*,
    import_if_available: :*,

    # ecto
    create: :*,
    drop: :*,
    remove: :*,
    field: :*,
    schema: :*,
    add: :*,
    rename: :*,
    modify: :*,
    execute: :*,
    from: :*,

    # vex
    validates: :*,

    # plug
    plug: :*,

    # phoenix
    pipe_through: :*,
    forward: :*,
    get: :*,
    post: :*,
    patch: :*,
    put: :*,
    delete: :*,
    resources: :*,
    pipeline: :*,
    scope: :*,
    socket: :*,
    adapter: :*,
    action_fallback: :*,

    # absinthe
    import_types: :*,
    object: :*,
    field: :*,
    arg: :*,
    resolve: :*
  ]
]
