defmodule Day3.MullItOver do
  @regex ~r/mul\((\d{1,3}),(\d{1,3})\)/

  def calculate(file_path) do
    {:ok, text} = file_path
    |> File.read()
    calculate_mul(text)
  end

  def calculate_mul(line) do
    @regex
    |> Regex.scan(line, capture: :all_but_first)
    |> Enum.reduce(0, fn [n1, n2], acc ->
      {mul1, _} = Integer.parse(n1)
      {mul2, _} = Integer.parse(n2)
      acc + mul1 * mul2
    end)
  end
end
