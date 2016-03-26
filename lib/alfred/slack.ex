defmodule Alfred.Slack do
  use Slack

  @token Application.get_env(:alfred, :slack)[:token]

  def start_link, do: start_link(@token, [])
end
