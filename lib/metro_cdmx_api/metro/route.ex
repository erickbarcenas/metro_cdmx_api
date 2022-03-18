defmodule MetroCdmxApi.Metro.Route do
  @moduledoc """
  The Metro context.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "route" do
    field :origin, :string
    field :dest, :string
  end

  def route_changeset(route, _params) do
    IO.inspect(1)
    # route
    #  |> cast(params, [:origin, :dest])
    #  |> get_route
  end
end
