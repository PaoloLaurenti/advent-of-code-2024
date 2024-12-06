defmodule Day3.MullItOver do
  @regex ~r/mul\((\d{1,3}),(\d{1,3})\)/

  def calculate(file_path) do
    file_path
    |> read_input_text()
    |> calculate_mul()
  end

  def calculate_with_do_dont(file_path) do
    file_path
    |> read_input_text()
    |> String.replace("\n", "")
    |> calculate_mul_with_do_dont()
  end

  defp read_input_text(file_path) do
    {:ok, text} = File.read(file_path)
    text
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

  def calculate_mul_with_do_dont(line) do
    [first_part | rest] = String.split(line, "don't()")

    first_part_mul = calculate_mul(first_part)

    Enum.reduce(rest, first_part_mul, fn part, sum ->
      calculate_mul_with_do(part) + sum
    end)
  end

  defp calculate_mul_with_do(text) do
    if String.contains?(text, "do()") do
      text
      |> String.split("do()", parts: 2)
      |> Enum.at(1)
      |> calculate_mul()
    else
      0
    end
  end
end
