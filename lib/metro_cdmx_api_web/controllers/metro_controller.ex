defmodule MetroCdmxApiWeb.MetroController do
  use MetroCdmxApiWeb, :controller

  alias MetroCdmxApi.Metro
  alias MetroCdmxApi.Metro.Route

  def show(conn, params) do

    origin = params["origin"]
    dest = params["dest"]
    Metro.get_route(origin, dest)
    render(conn, "show.json", %{origin: origin, dest: dest})
  end
end
