defmodule Mindex.Core.Board do
  defstruct answer: [], guesses: []

  alias Mindex.Core.Score

  @spec new :: %Mindex.Core.Board{answer: list(), guesses: list()}
  def new, do: new(random_answer())

  @spec new(answer :: list()) :: %Mindex.Core.Board{answer: list(), guesses: list()}
  def new([_a, _b, _c, _d] = answer), do: %__MODULE__{answer: answer}

  @spec random_answer :: list
  def random_answer, do: 1..8 |> Enum.shuffle() |> Enum.take(4)

  @spec move(%__MODULE__{}, guess :: list()) :: %__MODULE__{}
  def move(board, guess), do: %{board | guesses: [guess | board.guesses]}

  @spec won?(board :: %__MODULE__{}) :: boolean
  def won?(%{guesses: [guess | _guesses], answer: answer}) when guess == answer, do: true
  def won?(_board), do: false

  @spec lost?(board :: %__MODULE__{}) :: boolean
  def lost?(board), do: !won?(board) and length(board.guesses) == 10

  @spec to_string(%__MODULE__{}) :: list()
  def to_string(board), do: board |> status() |> build_string()

  defp status(%{answer: answer, guesses: guesses} = board) do
    %{won: won?(board), lost: lost?(board), rows: rows(guesses, answer)}
  end

  defp rows(guesses, answer), do: Enum.map(guesses, &row(&1, answer))

  defp row(guess, answer), do: %{guess: guess, score: Score.new(guess, answer)}

  defp build_string(%{rows: rows}), do: Enum.map(rows, &print_row/1)

  @spec print_guess(guess :: list()) :: String.t()
  def print_guess([a, b, c, d]) do
    IO.inspect("Guess: #{a}, #{b}, #{c}, #{d}")
  end

  defp print_row(%{guess: guess, score: score}) do
    print_guess(guess)
    Score.render_string(score)
  end
end
