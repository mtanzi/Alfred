defmodule Alfred do
  use Application

  def start(_type, _args) do
    Alfred.Supervisor.start_link
  end
end
