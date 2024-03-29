defmodule Mindex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: MultiplayerServer}
    ]

    opts = [strategy: :one_for_one, name: Mindex.GameSupervisor]
    Supervisor.start_link(children, opts)
  end
end
