defmodule Day6.GuardGallivant do
  def count_guard_distinct_positions(file_path) do
    {map, guard_position} = get_map_from_file(file_path)
    IO.inspect(get_in(map, [90, 71]))
    IO.inspect(guard_position)
    predict_distinct_positions_visited_by_a_guard(map, guard_position, :north)
  end

  defp get_map_from_file(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce({%{}, {0, 0}}, fn {line, y_idx}, {map, guard_position} ->
      row =
        line
        |> String.split("", trim: true)
        |> Enum.map(fn pos_char ->
          case pos_char do
            "." ->
              :empty

            "^" ->
              :guard

            "#" ->
              :obstacle
          end
        end)
        |> Enum.with_index(fn element, index -> {index, element} end)
        |> Enum.into(%{})

      map = Map.put(map, y_idx, row)

      case Enum.find_index(row, fn {_, val} -> val == :guard end) do
        nil -> {map, guard_position}
        pos ->
          IO.inspect({pos, y_idx})
          {map, {pos, y_idx}}
      end
    end)
  end

  @spec predict_distinct_positions_visited_by_a_guard(
          any(),
          {any(), any()},
          :east | :north | :south | :west
        ) :: non_neg_integer()
  def predict_distinct_positions_visited_by_a_guard(map, initial_position, direction) do
    track_guard(map, initial_position, direction, [initial_position])
  end

  defp track_guard(map, current_guard_position, direction, visited_positions) do
    {map, next_guard_position, direction} =
      move_guard_single_position(map, current_guard_position, direction)

    if next_guard_position == :out do
      visited_positions |> Enum.uniq() |> Enum.count()
    else
      if current_guard_position == next_guard_position do
        new_direction = rotate_right(direction)
        track_guard(map, next_guard_position, new_direction, visited_positions)
      else
        track_guard(map, next_guard_position, direction, [next_guard_position | visited_positions])
      end
    end
  end

  defp move_guard_single_position(map, {x, y}, direction) do
    put_in(map, [y, x], :empty)
    {map, new_guard_position} = move_guard_in_direction(map, {x, y}, direction)
    {map, new_guard_position, direction}
  end

  defp move_guard_in_direction(map, {x, y}, :north) do
    if y == 0 do
      {map, :out}
    else
      if empty_position?(get_in(map, [y - 1, x])) do
        {map, {x, y - 1}}
      else
        {map, {x, y}}
      end
    end
  end

  defp move_guard_in_direction(map, {x, y}, :east) do
    map_width = map |> Map.get(0) |> Map.keys() |> length()

    if x == map_width - 1 do
      {map, :out}
    else
      if empty_position?(get_in(map, [y, x + 1])) do
        {map, {x + 1, y}}
      else
        {map, {x, y}}
      end
    end
  end

  defp move_guard_in_direction(map, {x, y}, :south) do
    map_height = map |> Map.keys() |> length()

    if y == map_height - 1 do
      {map, :out}
    else
      if empty_position?(get_in(map, [y + 1, x])) do
        {map, {x, y + 1}}
      else
        {map, {x, y}}
      end
    end
  end

  defp move_guard_in_direction(map, {x, y}, :west) do
    if x == 0 do
      {map, :out}
    else
      if empty_position?(get_in(map, [y, x - 1])) do
        {map, {x - 1, y}}
      else
        {map, {x, y}}
      end
    end
  end

  defp empty_position?(:obstacle), do: false
  defp empty_position?(_), do: true

  defp rotate_right(:north), do: :east
  defp rotate_right(:east), do: :south
  defp rotate_right(:south), do: :west
  defp rotate_right(:west), do: :north
end
