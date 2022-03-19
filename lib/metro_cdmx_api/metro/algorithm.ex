defmodule MetroCdmxApi.Metro.Algorithm do
  import SweetXml

  defmodule Line do
    defstruct [:name, :stations]
  end

  defmodule Station do
    defstruct [:name, :coords, :position]
  end

   @doc """
  ## Examples
    iex> MetroCDMXChallenge.metro_lines
    [
      %MetroCDMXChallenge.Line{
        name: "Linea 1",
        stations: [
          %MetroCDMXChallenge.Station{name: "Pantitlan", coords: "90 30"},
        ]
      },
      %MetroCDMXChallenge.Line{
        name: "Linea 3",
        stations: [
          %MetroCDMXChallenge.Station{name: "Universidad", coords: "90 30"},
          %MetroCDMXChallenge.Station{name: "Copilco", coords: "90 30"},
        ]
      }
    ]
  """

  def get_not_nil(res) do
    if res != nil do
      elem(res, 1)
    end
  end

  def find_element(all_lines, item_coords) do
    all_lines
    |> Enum.filter(fn {coord, _, _} -> coord == item_coords  end)
    |> Enum.at(0)
    |> get_not_nil()
  end

  ### Main functions ###
  ## PART 1
  def metro_lines(_dest, _origin) do
    xml_path = "./data/cdmx_challenge/cdmx_challenge.kml"
    xml = File.read!(xml_path)
    stations_aliases = get_stations_aliases(xml) # Return for example: ["1", "2", ...]
    all_stations = get_all_stations(xml)

    all_lines = get_all_lines(xml)
    #IO.inspect(all_stations)

    stations = Enum.map(stations_aliases, fn station_alias ->
      Enum.filter(all_stations, fn station -> station.alias == station_alias end)
      |> Enum.map(fn item -> %Station{
          name: item.name,
          coords: item.coords,
          position: find_element(all_lines, item.coords)
      } end)
    end)

    stations = Enum.map(stations, fn list ->
      Enum.sort_by(list, fn map -> map.position end)
    end)


    Enum.map(0..(Enum.count(stations_aliases) - 1), fn idx ->
      %Line{
        name: "Línea #{Enum.at(stations_aliases, idx)}",
        stations: Enum.at(stations, idx)
      }
    end)
  end

  def get_stations_aliases(xml) do
    xml
    |> xpath(~x"//Document/Folder[1]/Placemark/name/text()"l)
    |> Enum.map(fn l ->
      List.to_string(l) |> String.split(" ") |> Enum.at(1)
     end)
  end

  ## PART 2

  def greate_pair(g, Graph, pair) do
    one = Enum.at(pair, 0)
    two = Enum.at(pair, 1)
    g |> Graph.add_edge(one, two)
  end

  def metro_graph() do
    lines = metro_lines("", "")
    graph = Graph.new(type: :undirected)

    Enum.reduce(lines, graph, fn line, graph ->
      pair = Enum.chunk_every(line.stations, 2, 1, :discard)
      Enum.reduce(pair, graph, fn stations, graph ->
        Graph.add_edge(graph, List.first(stations).name, List.last(stations).name)
      end)
    end)
  end


  ### Analysis to obtain information from each station ###
  def get_all_stations(xml) do
    xml
    |> xpath(
      ~x"//Document/Folder[2]/Placemark"l,
      name: ~x"./name/text()",
      line: ~x"./description/text()",
      coords: ~x"./Point/coordinates/text()"
      )
    |> Enum.map(fn item -> mine_info_station(item) end)
  end
  def mine_info_station(item) do
    %{
       name: List.to_string(item.name) |> String.downcase() |> String.normalize(:nfd) |> String.replace(~r/[^a-z\s]/u, ""),
       alias: List.to_string(item.line) |> String.split(".") |> Enum.at(0) |> String.split(" ") |> Enum.at(1),
       coords: "#{item.coords}"  |>  String.replace(~r"[a-z /]", "") |> String.replace("\n", "")
    }
  end

  ### Analysis to obtain information on each metro line ###

  def get_all_lines(xml) do
    xml
    |> xpath(
      ~x"//Document/Folder[1]/Placemark"l,
      line: ~x"./name/text()",
      coords: ~x"./LineString/coordinates/text()"
      )
    |> Enum.map(fn item -> mine_info_line(item) end)

    |> Enum.map(fn line -> line.coords
        |> Enum.with_index()
        |> Enum.map(fn item ->
            Tuple.append(item, line.line)
          end)
    end)
    |> List.flatten()

  end

  def mine_info_line(item) do
    %{
       line: List.to_string(item.line) |> String.split(" ") |> Enum.at(1),
       coords: "#{item.coords}" |> String.split("\n") |> Enum.map(fn coord -> String.replace(coord, ~r"[a-z /]", "") end ) |> Enum.filter(fn x -> x != "" end)
    }
   end
end
