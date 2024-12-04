defmodule Day1.HistorianHysteria do
  alias Day1.Calculator

  def difference(file_path) do
    {list_1, list_2} = get_lists_of_location_ids(file_path)

    Calculator.list_difference(list_1, list_2)
  end

  def similarity(file_path) do
    {list_1, list_2} = get_lists_of_location_ids(file_path)

    Calculator.similarity_score(list_1, list_2)
  end

  defp get_lists_of_location_ids(file_path) do
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

    {Enum.reverse(list_1), Enum.reverse(list_2)}
  end
end

defmodule Day1.Calculator do
  def list_difference(list_1, list_2) do
    locations_ids_map_1 =
      list_1
      |> Enum.sort()
      |> Enum.with_index(fn element, index -> {index, element} end)
      |> Enum.into(%{})

    locations_ids_map_2 =
      list_2
      |> Enum.sort()
      |> Enum.with_index(fn element, index -> {index, element} end)
      |> Enum.into(%{})

    Enum.reduce(locations_ids_map_1, 0, fn {i, n}, difference ->
      number_2 = Map.fetch!(locations_ids_map_2, i)
      difference + abs(n - number_2)
    end)
  end

  def similarity_score(list_1, list_2) do
    frequencies = Enum.frequencies(list_2)

    Enum.reduce(list_1, 0, fn n, score ->
      appearances = Map.get(frequencies, n, 0)
      score + n * appearances
    end)
  end
end
