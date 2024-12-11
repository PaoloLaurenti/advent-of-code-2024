defmodule Day4.CeresSearch do
  def count_xmas_from_file(file_path) do
    {:ok, text} = File.read(file_path)

    text
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.map(fn {row, idx} -> {idx, String.split(row, "", trim: true)} end)
    |> Enum.into(%{})
    |> count_xmas()
  end

  def count_xmas(map) do
    map_info = %{
      height: map |> Map.keys() |> length,
      width: length(Map.get(map, 0, []))
    }

    {right_to_left_count, x_coordinates} =
      map
      |> Enum.reduce({0, []}, fn {row_ix, row}, {sum, x_coordinates} ->
        row_x_coordinates =
          row
          |> Enum.with_index()
          |> Enum.filter(fn {value, _ix} -> value == "X" end)
          |> Enum.map(fn {_value, ix} -> {ix, row_ix} end)

        x_coordinates = Enum.concat(x_coordinates, row_x_coordinates)
        sum = sum + count_in_line(row, ~r/XMAS/)
        {sum, x_coordinates}
      end)

    [
      &get_bottom_right_diagonal_line/3,
      &get_top_bottom_line/3,
      &get_bottom_left_diagonal_line/3,
      &get_right_to_left_line/3,
      &get_top_left_diagonal_line/3,
      &get_bottom_top_line/3,
      &get_top_right_diagonal_line/3
    ]
    |> Enum.reduce(right_to_left_count, fn fn_get_line, partial_sum ->
      line_count =
        x_coordinates
        |> Enum.map(&fn_get_line.(map, map_info, &1))
        |> Enum.map(&count_in_line(&1, ~r/^XMAS/))
        |> Enum.sum()

      partial_sum + line_count
    end)
  end

  defp count_in_line(line, regex) do
    line_text = Enum.join(line)

    Regex.scan(regex, line_text, capture: :all_but_first)
    |> Enum.count()
  end

  defp get_bottom_right_diagonal_line(
         map,
         %{height: height, width: width},
         {x, y} = _x_coordinate
       ) do
    Enum.reduce_while(0..max(height, width), [], fn step, line ->
      if x + step == width || y + step == height do
        {:halt, line}
      else
        char = map |> Map.get(y + step, []) |> Enum.at(x + step)
        {:cont, [char | line]}
      end
    end)
    |> Enum.reverse()
  end

  defp get_top_bottom_line(map, %{height: height}, {x, y} = _x_coordinate) do
    Enum.reduce_while(0..height, [], fn step, line ->
      if y + step > height do
        {:halt, line}
      else
        char = map |> Map.get(y + step, []) |> Enum.at(x)
        {:cont, [char | line]}
      end
    end)
    |> Enum.reverse()
  end

  defp get_bottom_left_diagonal_line(
         map,
         %{height: height, width: width},
         {x, y} = _x_coordinate
       ) do
    Enum.reduce_while(0..max(height, width), [], fn step, line ->
      next_x = if x - step < 0, do: 0, else: x - step

      if x - step < 0 || y + step > height do
        {:halt, line}
      else
        char = map |> Map.get(y + step, []) |> Enum.at(next_x)
        {:cont, [char | line]}
      end
    end)
    |> Enum.reverse()
  end

  defp get_right_to_left_line(map, _map_info, {x, y} = _x_coordinate) do
    map |> Map.get(y) |> Enum.slice(0..x) |> Enum.reverse()
  end

  defp get_top_left_diagonal_line(
         map,
         %{height: height, width: width},
         {x, y} = _x_coordinate
       ) do
    Enum.reduce_while(0..max(height, width), [], fn step, line ->
      next_x = if x - step < 0, do: 0, else: x - step
      next_y = if y - step < 0, do: 0, else: y - step

      if x - step < 0 || y - step < 0 do
        {:halt, line}
      else
        char = map |> Map.get(next_y, []) |> Enum.at(next_x)
        {:cont, [char | line]}
      end
    end)
    |> Enum.reverse()
  end

  defp get_bottom_top_line(map, _map_info, {x, y} = _x_coordinate) do
    Enum.reduce_while(0..y, [], fn step, line ->
      if y - step < 0 do
        {:halt, line}
      else
        char = map |> Map.get(y - step, []) |> Enum.at(x)
        {:cont, [char | line]}
      end
    end)
    |> Enum.reverse()
  end

  defp get_top_right_diagonal_line(
         map,
         %{height: height, width: width},
         {x, y} = _x_coordinate
       ) do
    Enum.reduce_while(0..max(height, width), [], fn step, line ->
      next_y = if y - step < 0, do: 0, else: y - step

      if x + step > width || y - step < 0 do
        {:halt, line}
      else
        char = map |> Map.get(next_y, []) |> Enum.at(x + step)
        {:cont, [char | line]}
      end
    end)
    |> Enum.reverse()
  end
end
