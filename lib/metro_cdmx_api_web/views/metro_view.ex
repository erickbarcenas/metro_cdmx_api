defmodule MetroCdmxApiWeb.MetroView do
  @moduledoc """
      View for Metro
    """
  use MetroCdmxApiWeb, :view

  def render("route.json", %{origin: origin, dest: dest}) do
    %{
      origin: origin,
      dest: dest,
      itinerary: []
    }
  end
end
