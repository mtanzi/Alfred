defmodule Alfred.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, [])
  end

  def init(:ok) do
    token = Application.get_env(:alfred, :slack)[:token]

    children = [
      worker(Alfred.Base, [token, []]),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
