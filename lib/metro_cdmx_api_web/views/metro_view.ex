defmodule MetroCdmxApiWeb.MetroView do
  @moduledoc """
      View for Metro
    """
  use MetroCdmxApiWeb, :view

  def render("show.json", %{origin: origin, dest: dest}) do
    %{
      origin: origin,
      dest: dest,
      itinerary: []
    }
  end
end
