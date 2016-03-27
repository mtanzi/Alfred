defmodule Alfred.Slack do
  use Slack

  @token Application.get_env(:alfred, :slack)[:token]

  def start_link, do: start_link(@token, [])

  def handle_message(message = %{type: "message"}, slack, state) do
    handle_response(message, slack)
    {:ok, state ++ [message.text]}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end

  def handle_response(message = %{text: "Hi alfred"}, slack) do
    send_message("Hi Marco", message.channel, slack)
  end

  def handle_response(message, slack) do
    %{room: room, sensor: sensor} = Alfred.ApiAi.Api.query(message.text)

    send_message("#{sensor} in #{room}", message.channel, slack)
  end


end
