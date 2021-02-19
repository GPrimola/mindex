defmodule Mindex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Mindex.Boundary.Server

  def start(_type, _args) do
    children = [
      {Server, :game_board}
    ]

    opts = [strategy: :one_for_one, name: Mindex.GameSupervisor]
    Supervisor.start_link(children, opts)
  end
end
