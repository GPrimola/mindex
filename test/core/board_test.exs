defmodule Mindex.Core.BoardTest do
  use ExUnit.Case

  alias Mindex.Core.Board

  describe "new/0" do
    test "should create a board with a random answer" do
      %Board{answer: answer} = Board.new()

      assert Enum.count(answer) == 4
      assert is_list(answer)
    end

    test "should create a board with empty guesses" do
      %Board{guesses: []} = Board.new()
    end
  end

  describe "new/1" do
    test "should create a board with the provided answer" do
      answer_param = [1, 2, 3, 4]
      %Board{answer: ^answer_param} = Board.new(answer_param)
    end
  end

  describe "move/2" do
    test "should add a guess to board's guesses" do
      board = Board.new()
      assert length(board.guesses) == 0

      board = Board.move(board, [1, 2, 3, 4])
      assert length(board.guesses) == 1
    end
  end

  describe "won?/1" do
    test "should be true when guess is like answer" do
      answer = [1, 2, 3, 4]
      board = Board.new(answer)

      board = Board.move(board, [1, 2, 3, 4])
      assert Board.won?(board)
    end

    test "should be false when guess is not answer" do
      answer = [1, 2, 3, 4]
      board = Board.new(answer)

      board = Board.move(board, [4, 3, 2, 1])
      refute Board.won?(board)
    end
  end

  describe "lost?/1" do
    test "should be true when no guess was right and total guesses is 10" do
      answer = [1, 2, 3, 4]
      guesses = Stream.repeatedly(fn -> Enum.take(5..8, 4) end) |> Enum.take(10)
      board = %Board{answer: answer, guesses: guesses}

      assert Board.lost?(board)
    end

    test "should be false when guess is the answer" do
      answer = [1, 2, 3, 4]
      board = Board.new(answer)

      board = Board.move(board, [1, 2, 3, 4])
      refute Board.lost?(board)
    end

    test "should be false when total guesses is not 10 yet" do
      answer = [1, 2, 3, 4]
      board = Board.new(answer)

      board = Board.move(board, [4, 3, 2, 1])
      assert length(board.guesses) < 10
      refute Board.lost?(board)
    end
  end
end
