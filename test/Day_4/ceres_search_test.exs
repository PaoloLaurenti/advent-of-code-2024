defmodule Day4.CeresSearchTest do
  use ExUnit.Case

  describe "count XMAS " do
    test "right to left, 1" do
      count = Day4.CeresSearch.count_xmas(%{0 => ["X", "M", "A", "S"]})
      assert count == 1
    end

    test "right to left, 2" do
      count = Day4.CeresSearch.count_xmas(%{0 => ["X", "M", "A", "S", "X", "M", "A", "S"]})
      assert count == 2
    end

    test "right to left with previous chars, 1" do
      count = Day4.CeresSearch.count_xmas(%{0 => ["X", "M", "A", "X", "M", "A", "S"]})
      assert count == 1
    end

    test "right to left in many lines" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["X", "M", "A", "S"],
          1 => ["X", "M", "A", "-"],
          2 => ["X", "M", "A", "-"],
          3 => ["X", "M", "A", "S"]
        })

      assert count == 2
    end

    test "diagonal bottom right, 1" do
      count = Day4.CeresSearch.count_xmas(%{
        0 => ["X", "-", "-", "-"],
        1 => ["-", "M", "-", "-"],
        2 => ["-", "-", "A", "-"],
        3 => ["-", "-", "-", "S"],
      })
      assert count == 1
    end

    test "top to bottom" do
    end

    test "diagonal bottom left" do
    end

    test "left to right" do
    end

    test "diagonal top left" do
    end

    test "bottom to top" do
    end

    test "diagonal top right" do
    end
  end
end
