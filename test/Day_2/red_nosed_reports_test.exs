defmodule Day2.RedNosedReportsTest do
  use ExUnit.Case
  alias Day2.LevelsReport

  describe "With file" do
    test "report safety" do
      reports_safe_count = Day2.RedNosedReports.count_safe_reports("test/Day_2/input.txt")
      assert 534 == reports_safe_count
    end

    test "report safety with dampener" do
      reports_safe_count = Day2.RedNosedReports.count_safe_reports_with_dampener("test/Day_2/input.txt")
      assert 577 == reports_safe_count
    end
  end

  describe "report of" do
    test "one level, always safe" do
      report = [42]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    test "two increasing levels by 4, unsafe" do
      report = [42, 46]
      safe = LevelsReport.safe?(report)
      refute safe
    end

    test "two increasing levels by 5, unsafe" do
      report = [42, 47]
      safe = LevelsReport.safe?(report)
      refute safe
    end

    test "two increasing levels by 1, safe" do
      report = [42, 43]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    test "two increasing levels by 2, safe" do
      report = [42, 44]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    test "two increasing levels by 3, safe" do
      report = [42, 45]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    test "two decreasing levels by 1, safe" do
      report = [42, 41]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    test "two decreasing levels by 4, unsafe" do
      report = [42, 38]
      safe = LevelsReport.safe?(report)
      refute safe
    end

    test "two decreasing levels by 2, safe" do
      report = [42, 40]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    test "two decreasing levels by 3, safe" do
      report = [42, 39]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    test "two equal levels, unsafe" do
      report = [42, 42]
      safe = LevelsReport.safe?(report)
      refute safe
    end

    test "three increasing levels by 1 <--> 3, safe" do
      report = [42, 43, 45]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    test "three increasing and decreasing levels, unsafe" do
      report = [42, 43, 41]
      safe = LevelsReport.safe?(report)
      refute safe
    end

    test "three decreasing levels by 1 <--> 3, safe" do
      report = [45, 43, 41]
      safe = LevelsReport.safe?(report)
      assert safe
    end

    for {report, expected_safety} <- [
          {[7, 6, 4, 2, 1], true},
          {[1, 2, 7, 8, 9], false},
          {[9, 7, 6, 2, 1], false},
          {[8, 6, 4, 4, 1], false},
          {[1, 3, 6, 7, 9], true}
        ] do
      test "report example #{inspect(report)}" do
        safe = LevelsReport.safe?(unquote(report))
        assert unquote(expected_safety) == safe
      end
    end
  end

  describe "dampener" do
    test "already safe, still safe" do
      report = [45, 43, 41]
      safe = LevelsReport.safe_with_dampener?(report)
      assert safe
    end

    test "two increasing levels by 4 unsafe, become safe" do
      report = [42, 46]
      safe = LevelsReport.safe_with_dampener?(report)
      assert safe
    end

    test "three increasing and decreasing levels unsafe, become safe" do
      report = [42, 43, 41]
      safe = LevelsReport.safe_with_dampener?(report)
      assert safe
    end

    for {report, expected_safety} <- [
          {[7, 6, 4, 2, 1], true},
          {[1, 2, 7, 8, 9], false},
          {[9, 7, 6, 2, 1], false},
          {[1, 3, 2, 4, 5], true},
          {[8, 6, 4, 4, 1], true},
          {[1, 3, 6, 7, 9], true}
        ] do
      test "report example #{inspect(report)}" do
        safe = LevelsReport.safe_with_dampener?(unquote(report))
        assert unquote(expected_safety) == safe
      end
    end
  end
end
