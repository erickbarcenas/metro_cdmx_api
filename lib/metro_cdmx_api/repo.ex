defmodule MetroCdmxApi.Repo do
  use Ecto.Repo,
    otp_app: :metro_cdmx_api,
    adapter: Ecto.Adapters.Postgres
end
