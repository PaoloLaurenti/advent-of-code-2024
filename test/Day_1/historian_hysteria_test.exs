defmodule Day1.HistorianHysteriaTest do
  use ExUnit.Case
  alias Day1.Calculator
  alias Day1.HistorianHysteria

  describe "With file" do
   test "Calculate difference" do
    difference = HistorianHysteria.difference("test/Day_1/input.txt")
    IO.puts("Difference is #{difference}")
   end

   test "Calculate similarity" do
    difference = HistorianHysteria.similarity("test/Day_1/input.txt")
    IO.puts("Similarity is #{difference}")
   end
  end

  describe "Distance calculator" do
    test "two lists of one element, equals ones" do
      list_1 = [42]
      list_2 = [42]

      difference = Calculator.list_difference(list_1, list_2)

      assert difference == 0
    end

    test "two lists of one element, first greater then second" do
      list_1 = [42]
      list_2 = [40]

      difference = Calculator.list_difference(list_1, list_2)

      assert difference == 2
    end

    test "two lists of one element, second greater then first" do
      list_1 = [40]
      list_2 = [42]

      difference = Calculator.list_difference(list_1, list_2)

      assert difference == 2
    end

    test "two equals lists of two elements" do
      list_1 = [1, 2]
      list_2 = [1, 2]

      difference = Calculator.list_difference(list_1, list_2)

      assert difference == 0
    end

    test "two lists of two elements" do
      list_1 = [1, 2]
      list_2 = [3, 2]

      difference = Calculator.list_difference(list_1, list_2)

      assert difference == 2
    end

    test "two lists of two elements, with duplicated numbers" do
      list_1 = [1, 2]
      list_2 = [3, 3]

      difference = Calculator.list_difference(list_1, list_2)

      assert difference == 3
    end

    test "two lists of many elements" do
      list_1 = [3, 4, 2, 1, 3, 3]
      list_2 = [4, 3, 5, 3, 9, 3]

      difference = Calculator.list_difference(list_1, list_2)

      assert difference == 11
    end
  end

  describe "Similarity calculator" do
    test "two lists one item each, different values" do

    end

    test "two lists one item each, same values" do
      list_1 = [42]
      list_2 = [42]
      similarity_score = Calculator.similarity_score(list_1, list_2)
      assert similarity_score == 42
    end

    test "two lists one item each, all different values" do
      list_1 = [42]
      list_2 = [44]
      similarity_score = Calculator.similarity_score(list_1, list_2)
      assert similarity_score == 0
    end

    test "two lists two items each, all same values" do
      list_1 = [3, 3]
      list_2 = [3, 3]
      similarity_score = Calculator.similarity_score(list_1, list_2)
      assert similarity_score == 12
    end

    test "two lists two items each, all different values" do
      list_1 = [3, 2]
      list_2 = [4, 6]
      similarity_score = Calculator.similarity_score(list_1, list_2)
      assert similarity_score == 0
    end

    test "two lists, generic example" do
      list_1 = [3, 4, 2, 1, 3, 3]
      list_2 = [4, 3, 5, 3, 9, 3]
      similarity_score = Calculator.similarity_score(list_1, list_2)
      assert similarity_score == 31
    end
  end
end
