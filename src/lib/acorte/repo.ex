defmodule Acorte.Repo do
  use Ecto.Repo,
    otp_app: :acorte,
    adapter: Ecto.Adapters.Postgres
end
