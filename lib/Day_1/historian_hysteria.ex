defmodule Day1.HistorianHysteria do
  alias Day1.Calculator

  def calculate(file_path) do
    {list_1, list_2} =
      File.stream!(file_path)
      |> Stream.map(fn row ->
        String.split(row, " ", trim: true)
      end)
      |> Enum.reduce({[], []}, fn [id_1, id_2], {list_1, list_2} ->
        {id_1, _} = Integer.parse(id_1)
        {id_2, _} = Integer.parse(id_2)
        {[id_1 | list_1], [id_2 | list_2]}
      end)

    Calculator.list_difference(Enum.reverse(list_1), Enum.reverse(list_2))
  end
end

defmodule Day1.Calculator do
  def list_difference(list_1, list_2) do
    _list_difference(Enum.with_index(list_1), Enum.with_index(list_2))
  end

  def _list_difference([], []) do
    0
  end

  def _list_difference(list_1, list_2) do
    location_id_1 = Enum.min_by(list_1, fn {n, _} -> n end)
    location_id_2 = Enum.min_by(list_2, fn {n, _} -> n end)

    rest_list_1 = Enum.filter(list_1, &(&1 !== location_id_1))
    rest_list_2 = Enum.filter(list_2, &(&1 !== location_id_2))

    {number_1, _} = location_id_1
    {number_2, _} = location_id_2
    abs(number_1 - number_2) + _list_difference(rest_list_1, rest_list_2)
  end
end
