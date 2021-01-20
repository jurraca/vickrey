defmodule Vickrey.Repo do
  use Ecto.Repo,
    otp_app: :vickrey,
    adapter: Ecto.Adapters.Postgres
end
