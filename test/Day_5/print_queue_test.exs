defmodule Day5.PrintQueueTest do
  use ExUnit.Case

  describe "calculate sum of middle page number of correct updates, with" do
    test "one rule, one page update in the right order" do
      rules = [{42, 13}]
      pages_updates = [[75, 42, 13]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      assert result == 42
    end

    test "one rule, one page update in the wrong order" do
      rules = [{42, 13}]
      pages_updates = [[13, 42, 75]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      assert result == 0
    end

    test "one rule, one page update not relevant for the rule" do
      rules = [{42, 13}]
      pages_updates = [[14, 43, 75]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      assert result == 43
    end

    test "two rules, one page update in the right order" do
      rules = [{42, 13}, {75, 42}]
      pages_updates = [[75, 42, 13]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      assert result == 42
    end

    test "two rules, one page update in the wrong order breaking one rule" do
      rules = [{42, 13}, {75, 42}]
      pages_updates = [[42, 75, 13]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      assert result == 0
    end

    test "two rules, one page update in the wrong order breaking two rules" do
      rules = [{42, 13}, {75, 42}]
      pages_updates = [[13, 42, 75]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      assert result == 0
    end

    test "one rule, two page updates in the right order" do
      rules = [{42, 13}]
      pages_updates = [[75, 42, 13], [23, 42, 17, 13, 2]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      # 42 + 17
      assert result == 59
    end

    test "two rules, two page updates in the right order" do
      rules = [{42, 13}, {75, 42}]
      pages_updates = [[75, 42, 13], [11, 75, 23, 17, 42, 2, 13]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      # 42 + 17
      assert result == 59
    end

    test "two rules, two page updates in the wrong order" do
      rules = [{42, 13}, {75, 42}]
      pages_updates = [[42, 75, 13], [11, 1, 23, 17, 42, 75, 13]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      assert result == 0
    end

    test "ignore rules not applicable to pages updates" do
      rules = [{42, 13}, {42, 56}, {75, 42}]
      pages_updates = [[75, 42, 13], [11, 75, 23, 17, 42, 2, 13]]
      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      # 42 + 17
      assert result == 59
    end

    test "example" do
      rules = [
        {47, 53},
        {97, 13},
        {97, 61},
        {97, 47},
        {75, 29},
        {61, 13},
        {75, 53},
        {29, 13},
        {97, 29},
        {53, 29},
        {61, 53},
        {97, 53},
        {61, 29},
        {47, 13},
        {75, 47},
        {97, 75},
        {47, 61},
        {75, 61},
        {47, 29},
        {75, 13},
        {53, 13}
      ]

      pages_updates = [
        [75, 47, 61, 53, 29],
        [97, 61, 53, 29, 13],
        [75, 29, 13],
        [75, 97, 47, 61, 53],
        [61, 13, 29],
        [97, 13, 75, 29, 47]
      ]

      result = Day5.PrintQueue.sum_middle_page_numbers_of_correct_updates(rules, pages_updates)
      assert result == 143
    end
  end

  describe "calculate sum of middle pages of fixed page updates with" do
    test "one rule, one right page update" do
      rules = [{42, 13}]
      pages_updates = [[23, 42, 13, 75, 1]]

      result =
        Day5.PrintQueue.sum_middle_page_numbers_of_fixed_wrong_updates(rules, pages_updates)

      assert result == 0
    end

    test "one rule, one wrong page update" do
      rules = [{42, 13}]
      pages_updates = [[13, 42, 23, 75, 1]]

      result =
        Day5.PrintQueue.sum_middle_page_numbers_of_fixed_wrong_updates(rules, pages_updates)

      assert result == 23
    end

    test "one rule, two right page updates" do
      rules = [{42, 13}]
      pages_updates = [[23, 42, 13, 75, 1], [1, 42, 11, 25, 13]]

      result =
        Day5.PrintQueue.sum_middle_page_numbers_of_fixed_wrong_updates(rules, pages_updates)

      assert result == 0
    end

    test "one rule, two wrong page updates" do
      rules = [{42, 13}]
      pages_updates = [[13, 42, 23, 75, 1], [1, 13, 11, 25, 42]]

      result =
        Day5.PrintQueue.sum_middle_page_numbers_of_fixed_wrong_updates(rules, pages_updates)

      assert result == 36 #23 + 13
    end

    test "two rules, one right page update" do
      rules = [{42, 13}, {13, 1}]
      pages_updates = [[23, 42, 13, 75, 1]]

      result =
        Day5.PrintQueue.sum_middle_page_numbers_of_fixed_wrong_updates(rules, pages_updates)

      assert result == 0
    end

    test "two rules, one wrong page update violating only one rule" do
      rules = [{42, 13}, {1, 13}]
      pages_updates = [[23, 42, 13, 75, 1]]

      result =
        Day5.PrintQueue.sum_middle_page_numbers_of_fixed_wrong_updates(rules, pages_updates)

      assert result == 1
    end

    test "two rules, one wrong page update violating both rules" do
      rules = [{42, 13}, {1, 13}]
      pages_updates = [[23, 13, 42, 75, 1]]

      result =
        Day5.PrintQueue.sum_middle_page_numbers_of_fixed_wrong_updates(rules, pages_updates)

      assert result == 1
    end

    test "example" do
      rules = [
        {47, 53},
        {97, 13},
        {97, 61},
        {97, 47},
        {75, 29},
        {61, 13},
        {75, 53},
        {29, 13},
        {97, 29},
        {53, 29},
        {61, 53},
        {97, 53},
        {61, 29},
        {47, 13},
        {75, 47},
        {97, 75},
        {47, 61},
        {75, 61},
        {47, 29},
        {75, 13},
        {53, 13}
      ]

      pages_updates = [
        [75, 47, 61, 53, 29],
        [97, 61, 53, 29, 13],
        [75, 29, 13],
        [75, 97, 47, 61, 53],
        [61, 13, 29],
        [97, 13, 75, 29, 47]
      ]

      result = Day5.PrintQueue.sum_middle_page_numbers_of_fixed_wrong_updates(rules, pages_updates)
      assert result == 123
    end
  end

  describe "calculate from file" do
    {result1, result2} = Day5.PrintQueue.calculate("test/Day_5/input.txt")
    assert result1 == 6612
    assert result2 == 4944
  end
end
