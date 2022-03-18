defmodule MetroCdmxApiWeb.PageController do
  use MetroCdmxApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
