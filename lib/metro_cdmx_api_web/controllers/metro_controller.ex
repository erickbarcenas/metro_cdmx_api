defmodule MetroCdmxApiWeb.MetroController do
  use MetroCdmxApiWeb, :controller
  # alias MetroCdmxApi.Route

  def show(conn, params) do
    #changeset = Route.route_changeset(%Route{}, params)

    #if 1 do
      conn
      |> put_status(200)
      |> json(%{data: params})
    #end

  end
end
