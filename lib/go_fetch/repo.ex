defmodule GoFetch.Repo do
  use Ecto.Repo,
    otp_app: :go_fetch,
    adapter: Ecto.Adapters.SQLite3
end
