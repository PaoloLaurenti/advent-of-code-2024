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
          1 => ["X", "-", "-", "S"],
          2 => ["X", "M", "A", "-"],
          3 => ["X", "M", "A", "S"]
        })

      assert count == 2
    end

    test "diagonal bottom right, many" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["X", "-", "-", "-"],
          1 => ["X", "M", "-", "-"],
          2 => ["-", "M", "A", "-"],
          3 => ["-", "-", "A", "S"],
          4 => ["-", "-", "-", "S"]
        })

      assert count == 2
    end

    test "top to bottom" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["X", "X", "-"],
          1 => ["-", "M", "X"],
          2 => ["-", "A", "M"],
          3 => ["-", "S", "A"],
          4 => ["-", "-", "S"]
        })

      assert count == 2
    end

    test "diagonal bottom left" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["X", "-", "-", "X"],
          1 => ["X", "-", "M", "X"],
          2 => ["-", "A", "M", "-"],
          3 => ["S", "A", "A", "S"],
          4 => ["S", "-", "-", "S"]
        })

      assert count == 2
    end

    test "right to left" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["X", "-", "-", "-"],
          1 => ["S", "A", "M", "X"],
          2 => ["-", "A", "M", "-"],
          3 => ["S", "A", "M", "X"],
          4 => ["-", "X", "-", "S"]
        })

      assert count == 2
    end

    test "diagonal top left" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["S", "-", "U", "X"],
          1 => ["S", "A", "M", "A"],
          2 => ["-", "A", "M", "-"],
          3 => ["M", "A", "M", "X"],
          4 => ["S", "-", "-", "X"]
        })

      assert count == 2
    end

    test "bottom to top" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["X", "S", "-"],
          1 => ["-", "A", "S"],
          2 => ["-", "M", "A"],
          3 => ["-", "X", "M"],
          4 => ["-", "X", "X"]
        })

      assert count == 2
    end

    test "diagonal top right" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["X", "S", "-", "S"],
          1 => ["-", "A", "A", "S"],
          2 => ["-", "M", "A", "A"],
          3 => ["X", "M", "M", "M"],
          4 => ["X", "-", "X", "-"]
        })

      assert count == 2
    end

    test "example 1" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => [".", ".", ".", ".", "X", "X", "M", "A", "S", "."],
          1 => [".", "S", "A", "M", "X", "M", "S", ".", ".", "."],
          2 => [".", ".", ".", "S", ".", ".", "A", ".", ".", "."],
          3 => [".", ".", "A", ".", "A", ".", "M", "S", ".", "X"],
          4 => ["X", "M", "A", "S", "A", "M", "X", ".", "M", "M"],
          5 => ["X", ".", ".", ".", ".", ".", "X", "A", ".", "A"],
          6 => ["S", ".", "S", ".", "S", ".", "S", ".", "S", "S"],
          7 => [".", "A", ".", "A", ".", "A", ".", "A", ".", "A"],
          8 => [".", ".", "M", ".", "M", ".", "M", ".", "M", "M"],
          9 => [".", "X", ".", "X", ".", "X", "M", "A", "S", "X"]
        })

      assert count == 18
    end

    test "example 2" do
      count =
        Day4.CeresSearch.count_xmas(%{
          0 => ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
          1 => ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
          2 => ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
          3 => ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
          4 => ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
          5 => ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
          6 => ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
          7 => ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
          8 => ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
          9 => ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"]
        })

      assert count == 18
    end

    test "with input" do
      count = Day4.CeresSearch.count_xmas_from_file("test/Day_4/input.txt")
      assert count == 2536
    end
  end

  describe "count X-MAS" do
    test "one 0° X-MAS" do
      count =
        Day4.CeresSearch.count_crossed_mas(%{
          0 => ["M", "-", "M"],
          1 => ["-", "A", "-"],
          2 => ["S", "-", "S"]
        })

      assert count == 1
    end

    test "many 0° X-MAS" do
      count =
        Day4.CeresSearch.count_crossed_mas(%{
          0 => ["M", "M", "M", "M"],
          1 => ["-", "A", "A", "-"],
          2 => ["S", "S", "S", "S"]
        })

      assert count == 2
    end

    test "one 90° X-MAS" do
      count =
        Day4.CeresSearch.count_crossed_mas(%{
          0 => ["S", "-", "M"],
          1 => ["-", "A", "-"],
          2 => ["S", "-", "M"]
        })

      assert count == 1
    end

    test "one 180° X-MAS" do
      count =
        Day4.CeresSearch.count_crossed_mas(%{
          0 => ["S", "-", "S"],
          1 => ["-", "A", "-"],
          2 => ["M", "-", "M"]
        })

      assert count == 1
    end

    test "one 270° X-MAS" do
      count =
        Day4.CeresSearch.count_crossed_mas(%{
          0 => ["M", "-", "S"],
          1 => ["-", "A", "-"],
          2 => ["M", "-", "S"]
        })

      assert count == 1
    end

    test "overlapping X-MAS" do
      count =
        Day4.CeresSearch.count_crossed_mas(%{
          0 => ["S", "-", "M", "-", "S"],
          1 => ["-", "A", "-", "A", "-"],
          2 => ["S", "-", "M", "-", "S"]
        })

      assert count == 2
    end

    test "example" do
      count =
        Day4.CeresSearch.count_crossed_mas(%{
          0 => [".", "M", ".", "S", ".", ".", ".", ".", ".", "."],
          1 => [".", ".", "A", ".", ".", "M", "S", "M", "S", "."],
          2 => [".", "M", ".", "S", ".", "M", "A", "A", ".", "."],
          3 => [".", ".", "A", ".", "A", "S", "M", "S", "M", "."],
          4 => [".", "M", ".", "S", ".", "M", ".", ".", ".", "."],
          5 => [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
          6 => ["S", ".", "S", ".", "S", ".", "S", ".", "S", "."],
          7 => [".", "A", ".", "A", ".", "A", ".", "A", ".", "."],
          8 => ["M", ".", "M", ".", "M", ".", "M", ".", "M", "."],
          9 => [".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
        })

      assert count == 9
    end

    test "with input" do
      count = Day4.CeresSearch.count_crossed_mas_from_file("test/Day_4/input.txt")
      assert count == 0
    end
  end
end
