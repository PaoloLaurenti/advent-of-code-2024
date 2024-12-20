defmodule Day6.GuardGallivantTest do
  use ExUnit.Case

  describe "Predict distinct positions visited by a guard" do
    test "when she is in a position at the edge of the map" do
      map = %{0 => %{0 => :empty, 1 => :empty}, 1 => %{0 => :empty, 1 => :guard}}
      initial_position = {1, 1}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :south
        )

      assert prediction == 1
    end

    test "when she is in a position by many before the edge of the map, with no obstacles, South direction" do
      map = %{
        0 => %{0 => :empty, 1 => :guard},
        1 => %{0 => :empty, 1 => :empty},
        2 => %{0 => :empty, 1 => :empty},
        3 => %{0 => :empty, 1 => :empty}
      }

      initial_position = {1, 0}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :south
        )

      assert prediction == 4
    end

    test "when she is in a position by many before the edge of the map, with no obstacles, West direction" do
      map = %{
        0 => %{0 => :empty, 1 => :guard},
        1 => %{0 => :empty, 1 => :empty},
        2 => %{0 => :empty, 1 => :empty},
        3 => %{0 => :empty, 1 => :empty}
      }

      initial_position = {1, 0}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :west
        )

      assert prediction == 2
    end

    test "when she is in a position by many before the edge of the map, with no obstacles, North direction" do
      map = %{
        0 => %{0 => :empty, 1 => :empty},
        1 => %{0 => :empty, 1 => :empty},
        2 => %{0 => :empty, 1 => :empty},
        3 => %{0 => :empty, 1 => :guard}
      }

      initial_position = {1, 3}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :north
        )

      assert prediction == 4
    end

    test "when she is in a position by many before the edge of the map, with no obstacles, East direction" do
      map = %{
        0 => %{0 => :empty, 1 => :empty},
        1 => %{0 => :empty, 1 => :empty},
        2 => %{0 => :guard, 1 => :empty},
        3 => %{0 => :empty, 1 => :empty}
      }

      initial_position = {0, 2}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :east
        )

      assert prediction == 2
    end

    test "when she leaves the map after facing one obstacle" do
      map = %{
        0 => %{0 => :obstacle, 1 => :empty, 2 => :empty},
        1 => %{0 => :empty, 1 => :empty, 2 => :empty},
        2 => %{0 => :guard, 1 => :empty, 2 => :empty},
        3 => %{0 => :empty, 1 => :empty, 2 => :empty}
      }

      initial_position = {0, 2}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :north
        )

      assert prediction == 4
    end

    test "when she leaves the map after facing many obstacles" do
      map = %{
        0 => %{0 => :obstacle, 1 => :empty, 2 => :empty},
        1 => %{0 => :empty, 1 => :empty, 2 => :obstacle},
        2 => %{0 => :guard, 1 => :empty, 2 => :empty},
        3 => %{0 => :empty, 1 => :empty, 2 => :empty},
        4 => %{0 => :empty, 1 => :obstacle, 2 => :empty}
      }

      initial_position = {0, 2}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :north
        )

      assert prediction == 6
    end

    test "and don't count already visited positions" do
      map = %{
        0 => %{0 => :obstacle, 1 => :empty, 2 => :empty},
        1 => %{0 => :empty, 1 => :empty, 2 => :obstacle},
        2 => %{0 => :guard, 1 => :empty, 2 => :empty},
        3 => %{0 => :empty, 1 => :obstacle, 2 => :empty},
        4 => %{0 => :empty, 1 => :obstacle, 2 => :empty}
      }

      initial_position = {0, 2}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :north
        )

      assert prediction == 4
    end

    test "example" do
      map = %{
        0 => %{
          0 => :empty,
          1 => :empty,
          2 => :empty,
          3 => :empty,
          4 => :obstacle,
          5 => :empty,
          6 => :empty,
          7 => :empty,
          8 => :empty,
          9 => :empty
        },
        1 => %{
          0 => :empty,
          1 => :empty,
          2 => :empty,
          3 => :empty,
          4 => :empty,
          5 => :empty,
          6 => :empty,
          7 => :empty,
          8 => :empty,
          9 => :obstacle
        },
        2 => %{
          0 => :empty,
          1 => :empty,
          2 => :empty,
          3 => :empty,
          4 => :empty,
          5 => :empty,
          6 => :empty,
          7 => :empty,
          8 => :empty,
          9 => :empty
        },
        3 => %{
          0 => :empty,
          1 => :empty,
          2 => :obstacle,
          3 => :empty,
          4 => :empty,
          5 => :empty,
          6 => :empty,
          7 => :empty,
          8 => :empty,
          9 => :empty
        },
        4 => %{
          0 => :empty,
          1 => :empty,
          2 => :empty,
          3 => :empty,
          4 => :empty,
          5 => :empty,
          6 => :empty,
          7 => :obstacle,
          8 => :empty,
          9 => :empty
        },
        5 => %{
          0 => :empty,
          1 => :empty,
          2 => :empty,
          3 => :empty,
          4 => :empty,
          5 => :empty,
          6 => :empty,
          7 => :empty,
          8 => :empty,
          9 => :empty
        },
        6 => %{
          0 => :empty,
          1 => :obstacle,
          2 => :empty,
          3 => :empty,
          4 => :guard,
          5 => :empty,
          6 => :empty,
          7 => :empty,
          8 => :empty,
          9 => :empty
        },
        7 => %{
          0 => :empty,
          1 => :empty,
          2 => :empty,
          3 => :empty,
          4 => :empty,
          5 => :empty,
          6 => :empty,
          7 => :empty,
          8 => :obstacle,
          9 => :empty
        },
        8 => %{
          0 => :obstacle,
          1 => :empty,
          2 => :empty,
          3 => :empty,
          4 => :empty,
          5 => :empty,
          6 => :empty,
          7 => :empty,
          8 => :empty,
          9 => :empty
        },
        9 => %{
          0 => :empty,
          1 => :empty,
          2 => :empty,
          3 => :empty,
          4 => :empty,
          5 => :empty,
          6 => :obstacle,
          7 => :empty,
          8 => :empty,
          9 => :empty
        }
      }

      initial_position = {4, 6}

      prediction =
        Day6.GuardGallivant.predict_distinct_positions_visited_by_a_guard(
          map,
          initial_position,
          :north
        )

      assert prediction == 41
    end

    test "with input file" do
      prediction = Day6.GuardGallivant.count_guard_distinct_positions("test/Day_6/input.txt")
      assert prediction == 0
    end
  end
end
