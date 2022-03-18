defmodule MetroCdmxApi.Route do
  @moduledoc """
  The Metro context.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "route" do
    field :origin, :string
    field :dest, :string
  end

  def route_changeset(route, params) do
    route
      |> cast(params, [:origin, :dest])
      |> get_route
  end

  def get_route(_changeset) do
    # origin = get_field(changeset, :origin)
    # dest = get_field(changeset, :dest)
    1
  end
end
