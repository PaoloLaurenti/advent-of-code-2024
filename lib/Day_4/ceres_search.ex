defmodule Day4.CeresSearch do
  def count_xmas(map) do
    {right_to_left_count, x_coordinates} =
      map
      |> Enum.reduce({0, []}, fn {row_ix, row}, {sum, x_coordinates} ->
        row_x_coordinates =
          row
          |> Enum.with_index()
          |> Enum.filter(fn {value, _ix} -> value == "X" end)
          |> Enum.map(fn {_value, ix} -> {row_ix, ix} end)

        x_coordinates = Enum.concat(x_coordinates, row_x_coordinates)
        sum = sum + count_in_line(row)
        {sum, x_coordinates}
      end)

    bottom_right_diagonal_count =
      x_coordinates
      |> Enum.map(&get_bottom_right_diagonal(map, &1))
      |> Enum.map(&count_in_line(&1))
      |> Enum.sum()

    right_to_left_count + bottom_right_diagonal_count
  end

  defp count_in_line(line) do
    line_text = Enum.join(line)

    Regex.scan(~r/XMAS/, line_text, capture: :all_but_first)
    |> Enum.count()
  end

  defp get_bottom_right_diagonal(map, {x, y} = _x_coordinate) do
    height = map |> Map.keys() |> length
    width = length(Map.get(map, x))
    
  end
end
