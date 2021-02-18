defmodule Mindex.Core.ScoreTest do
  use ExUnit.Case

  alias Mindex.Core.Score, as: MyScore

  describe "new/2" do
    test "should return red: 4, white: 0 when guess == answer" do
      assert %{red: 4, white: 0} = MyScore.new([1, 2, 3, 4], [1, 2, 3, 4])
    end

    test "should return red: 2, white: 2 when guess is almost like answer" do
      guess = [1, 3, 2, 4]
      answer = [1, 2, 3, 4]
      assert %{red: 2, white: 2} = MyScore.new(guess, answer)
    end

    test "should return red: 0, white: 0 when guess has no elements in answer" do
      guess = [9, 8, 7, 6]
      answer = [1, 2, 3, 4]
      assert %{red: 0, white: 0} = MyScore.new(guess, answer)
    end
  end
end
