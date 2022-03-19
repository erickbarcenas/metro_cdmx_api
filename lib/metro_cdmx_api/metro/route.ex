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

  #defstruct [:origin, :dest]

  def routes_changeset(route, params) do
    route
      |> cast(params, [:origin, :dest])
      |> validate_required([:origin, :dest])
  end
end
