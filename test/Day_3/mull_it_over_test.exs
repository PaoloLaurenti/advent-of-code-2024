defmodule Day3.MullItOverTest do
  use ExUnit.Case

  describe "calculate sum of multiplication on multi-lines" do
    test "many muls" do
      result = Day3.MullItOver.calculate_mul("mul(4,2)\nmul(3,3)\nmul(2,1)")
      assert 19 == result
    end

    test "with input" do
      result = Day3.MullItOver.calculate("test/Day_3/input.txt")
      assert result == 174_960_292
    end

    test "with input with do don't" do
      result = Day3.MullItOver.calculate_with_do_dont("test/Day_3/input.txt")
      assert result == 56_275_602
    end
  end

  describe "calculate sum of multiplication on a single line with" do
    test "single mul" do
      result = Day3.MullItOver.calculate_mul("mul(42,212)")
      assert 8904 == result
    end

    test "many muls" do
      result = Day3.MullItOver.calculate_mul("mul(4,2)mul(3,3)mul(2,1)")
      assert 19 == result
    end

    test "no mul" do
      result = Day3.MullItOver.calculate_mul("asdasf")
      assert 0 == result
    end

    test "single mul with preceding chars" do
      result = Day3.MullItOver.calculate_mul("agsdmul(4,2)")
      assert 8 == result
    end

    test "single mul with following chars" do
      result = Day3.MullItOver.calculate_mul("mul(4,2)asdgsdfg")
      assert 8 == result
    end

    test "single mul with both preceding and following chars" do
      result = Day3.MullItOver.calculate_mul("asdfmul(4,2)dfasdfasd")
      assert 8 == result
    end

    test "single mul with one number with more than 3 digits" do
      result = Day3.MullItOver.calculate_mul("mul(4567,1)")
      assert 0 == result
    end

    test "two muls with chars between them" do
      result = Day3.MullItOver.calculate_mul("mul(411,2)sfasfmul(33,4)")
      assert 954 == result
    end

    test "two muls with chars between them and preceding/following chars to the first and the last one" do
      result = Day3.MullItOver.calculate_mul("dfasdmul(411,2)sfasfmul(33,4))dsfd")
      assert 954 == result
    end

    for {line, expected_result} <- [
          {"mul(4*", 0},
          {"mul(6,9!", 0},
          {"?(12,34)", 0},
          {"mul ( 2 , 4 )", 0},
          {"xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))", 161}
        ] do
      test "mul examples #{inspect(line)} -> #{inspect(expected_result)}" do
        result = Day3.MullItOver.calculate_mul(unquote(line))
        assert unquote(expected_result) == result
      end
    end
  end

  describe "calculate sum of multiplication with do/don't on a single line with" do
    test "muls with no do/don't" do
      result = Day3.MullItOver.calculate_mul_with_do_dont("mul(42,212)")
      assert 8904 == result
    end

    test "mulls with one single following don't and no mul after" do
      result = Day3.MullItOver.calculate_mul_with_do_dont("mul(42,212)afdsdon't()")
      assert 8904 == result
    end

    test "mulls with one single following don't and muls after" do
      result = Day3.MullItOver.calculate_mul_with_do_dont("mul(42,212)afdsdon't()mul(3,4)")
      assert 8904 == result
    end

    test "mulls with one single following don't, no mul after and then a do with no muls after" do
      result = Day3.MullItOver.calculate_mul_with_do_dont("mul(42,212)afdsdon't()sdfdsfdo()")
      assert 8904 == result
    end

    test "mulls with one single following don't, muls after and then a do with no muls after" do
      result =
        Day3.MullItOver.calculate_mul_with_do_dont("mul(42,212)afdsdon't()mul(4,5)sdfdsfdo()")

      assert 8904 == result
    end

    test "mulls with one single following don't, no mul after and then a do with muls after" do
      result =
        Day3.MullItOver.calculate_mul_with_do_dont("mul(42,212)afdsdon't())sdfdsfdo()mul(4,5)")

      assert 8924 == result
    end

    test "mulls with one single following don't, muls after and then a do with muls after" do
      result =
        Day3.MullItOver.calculate_mul_with_do_dont(
          "mul(42,212)afdsdon't())smul(2,3)dfdsfdo()mul(4,5)"
        )

      assert 8924 == result
    end

    test "following don'ts with no do's in the middle" do
      result =
        Day3.MullItOver.calculate_mul_with_do_dont(
          "mul(42,212)afdsdon't())smul(2,3)dfdsfdon't()mul(4,5)"
        )

      assert 8904 == result
    end

    test "following do with no don't's in the middle" do
      result =
        Day3.MullItOver.calculate_mul_with_do_dont(
          "mul(42,212)afdsdon't())smul(2,3)dfdsfdo()sdfsdgdo()mul(4,5)"
        )

      assert 8924 == result
    end

    test "example" do
      result =
        Day3.MullItOver.calculate_mul_with_do_dont(
          "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
        )

      assert 48 == result
    end
  end
end
