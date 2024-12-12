defmodule Day5.PrintQueue do
  def sum_middle_page_numbers_of_correct_updates(rules, pages_update) do
    Enum.map(pages_update, fn update ->
      if page_update_correct?(rules, update),
        do: middle_page(update),
        else: 0
    end)
    |> Enum.sum()
  end

  defp page_update_correct?(rules, update) do
    Enum.all?(rules, fn {previous, following} ->
      indexed_update = Enum.with_index(update) |> Enum.into(%{})
      previous_idx = Map.get(indexed_update, previous, -1)
      following_idx = Map.get(indexed_update, following, -1)

      res = previous_idx < 0 || following_idx < 0 || previous_idx < following_idx
      res
    end)
  end

  defp middle_page(page_update) do
    middle_idx = ((length(page_update) / 2) |> round) - 1
    Enum.at(page_update, middle_idx)
  end

  def calculate(file_path) do
    {rules, pages_updates} = get_data_from_file(file_path)
    rules = Enum.reverse(rules)
    pages_updates = Enum.reverse(pages_updates)
    sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
  end

  defp get_data_from_file(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> Enum.reduce({[], []}, fn line, {rules, pages_updates} ->
      if String.contains?(line, "|") do
        [rule_page1, rule_page2] = String.split(line, "|", trim: true)
        {rule_page1, _} = Integer.parse(rule_page1)
        {rule_page2, _} = Integer.parse(rule_page2)
        {[{rule_page1, rule_page2} | rules], pages_updates}
      else
        if String.contains?(line, ",") do
          pages = String.split(line, ",", trim: true)

          pages =
            Enum.map(pages, fn page ->
              {page, _} = Integer.parse(page)
              page
            end)

          {rules, [pages | pages_updates]}
        else
          {rules, pages_updates}
        end
      end
    end)
  end
end
