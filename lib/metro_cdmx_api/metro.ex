defmodule MetroCdmxApi.Metro do
  @moduledoc """
  The Metro context.
  """
  alias MetroCdmxApi.Metro.Route
  alias MetroCdmxApi.Metro.Algorithm


  def get_route(params) do
    chg = Route.routes_changeset(%Route{}, params)
    case chg.valid? do
      true ->
        get_path(chg.changes)
      false ->
          {:error, "invalid_params"}
    end
  end

  def get_path(%{dest: dest, origin: origin}) do
    # response = Algorithm.metro_lines(dest, origin)
    # |> Enum.at(0)

    # name = Map.get(response, :name)

    [
      %{
        line: "",
        origin: origin,
        dest: "",
        steps: 0
      },
      %{
        segment: 2,
        line: "",
        origin: "",
        dest: dest,
        steps: 3
      }
    ]

  end


end
