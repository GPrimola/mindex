defmodule Mindex.Core.Score do
  defstruct red: 0, white: 0

  @spec new(list, list) :: %__MODULE__{}
  def new(guess \\ [1, 3, 5, 8], answer \\ [1, 2, 3, 4]) do
    __struct__(red: count_red(guess, answer), white: count_white(guess, answer))
  end

  defp count_red(guess, answer) do
    guess
    |> Enum.zip(answer)
    |> Enum.count(fn {x, y} -> x == y end)
  end

  defp count_white(guess, answer) do
    size_count = Enum.count(answer)

    miss_count =
      (guess -- answer)
      |> Enum.count()

    red_count = count_red(guess, answer)

    size_count - red_count - miss_count
  end
end
