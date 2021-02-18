defmodule Mindex.Core.Score do
  defstruct red: 0, white: 0

  @red "R"
  @white "W"
  @blank "-"
  @max_length 4

  @spec new(list, list) :: %__MODULE__{}
  def new(guess \\ [1, 3, 5, 8], answer \\ [1, 2, 3, 4]) do
    __struct__(red: count_red(guess, answer), white: count_white(guess, answer))
  end

  @doc """
  Renders the score as a string. Examples:
    - "----": when no guess belongs to the final solution
    - "R---": when there's a guess in the right place
    - "W---": when there's a guess in the wrong place
    - "WWWW": when the guess is right but numbers in wrong place
    - "RRRR": when the game is won
  """
  @spec render_string(%{:red => non_neg_integer, :white => non_neg_integer}) ::
          String.t()
  def render_string(%{red: red, white: white}) do
    @red
    |> String.duplicate(red)
    |> Kernel.<>(String.duplicate(@white, white))
    |> Kernel.<>(String.duplicate(@blank, @max_length - red - white))
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
