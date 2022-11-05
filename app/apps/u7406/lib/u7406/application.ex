defmodule U7406.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      U7406.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: U7406.PubSub}
      # Start a worker by calling: U7406.Worker.start_link(arg)
      # {U7406.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: U7406.Supervisor)
  end
end
