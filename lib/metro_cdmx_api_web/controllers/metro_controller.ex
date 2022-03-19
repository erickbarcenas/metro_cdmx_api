defmodule MetroCdmxApiWeb.MetroController do
  use MetroCdmxApiWeb, :controller

  alias MetroCdmxApi.Metro
  # alias MetroCdmxApi.Metro.Route

  def show(conn, params) do
    origin = params["origin"]
    dest = params["dest"]
    itinerary = Metro.get_route(params)
    render(conn, "show.json", %{origin: origin, dest: dest, itinerary: itinerary})
  end
end
