defmodule Mindex.Boundary.Server do
  use GenServer
  alias Mindex.Core.Board

  def start_link(name) do
    opts = []
    GenServer.start_link(__MODULE__, opts, name: name)
  end

  def move(name, guess) do
    GenServer.call(name, {:move, guess})
  end

  @impl true
  def init(_opts) do
    {:ok, Board.new() |> IO.inspect(label: :answer)}
  end

  @impl true
  def handle_call({:move, guess}, _from, board) do
    new_board = Board.move(board, guess)
    {:reply, Board.to_string(new_board), new_board}
  end
end
