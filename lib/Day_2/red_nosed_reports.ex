defmodule Day2.RedNosedReports do
  alias Day2.LevelsReport

  def count_safe_reports(file_path) do
    file_path
    |> get_stream_of_number_lists()
    |> Stream.filter(&LevelsReport.safe?(&1))
    |> Enum.count()
  end

  def count_safe_reports_with_dampener(file_path) do
    file_path
    |> get_stream_of_number_lists()
    |> Stream.filter(&LevelsReport.safe_with_dampener?(&1))
    |> Enum.count()
  end

  defp get_stream_of_number_lists(file_path) do
    file_path
    |> File.stream!()
    |> Stream.map(&to_list/1)
  end

  defp to_list(levels) do
    levels
    |> String.trim()
    |> String.split(" ", trim: true)
    |> Enum.map(fn level ->
      {n, _} = Integer.parse(level)
      n
    end)
  end
end

defmodule Day2.LevelsReport do
  def safe?([_value | []]), do: true

  def safe?(report) do
    [first_level | _] = report

    {_, _, safety} =
      report
      |> Enum.drop(1)
      |> Enum.reduce_while({first_level, :nd, true}, fn level, {prev_level, trend, true} ->
        diff = level - prev_level

        if levels_difference_safe?(diff) && trend_safe?(trend, diff),
          do: {:cont, {level, get_trend_by(trend, diff), true}},
          else: {:halt, {level, get_trend_by(trend, diff), false}}
      end)

    safety
  end

  def safe_with_dampener?(report) do
    Enum.reduce_while(0..length(report), false, fn offset, _safety ->
      {_, rest} = List.pop_at(report, offset)
      safe? = safe?(rest)

      if safe?,
        do: {:halt, true},
        else: {:cont, false}
    end)
  end

  defp levels_difference_safe?(levels_difference) do
    abs_diff = abs(levels_difference)
    abs_diff > 0 && abs_diff <= 3
  end

  defp trend_safe?(
         current_trend,
         levels_difference
       ) do
    case current_trend do
      :nd -> true
      :asc -> levels_difference > 0
      :desc -> levels_difference < 0
    end
  end

  defp get_trend_by(:nd, levels_difference) do
    if levels_difference > 0, do: :asc, else: :desc
  end

  defp get_trend_by(current_trend, _), do: current_trend
end
