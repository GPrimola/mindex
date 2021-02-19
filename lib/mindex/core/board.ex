defmodule Mindex.Core.Board do
  defstruct answer: [], guesses: []

  @spec new :: %Mindex.Core.Board{answer: list(), guesses: list()}
  def new, do: new(random_answer())

  @spec new(answer :: list()) :: %Mindex.Core.Board{answer: list(), guesses: list()}
  def new([_a, _b, _c, _d] = answer), do: %__MODULE__{answer: answer}

  @spec random_answer :: list
  def random_answer, do: 1..8 |> Enum.shuffle() |> Enum.take(4)
end
