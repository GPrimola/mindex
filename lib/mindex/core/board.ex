defmodule Mindex.Core.Board do
  defstruct answer: [], guesses: []

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
end
