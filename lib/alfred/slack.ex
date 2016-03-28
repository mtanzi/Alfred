defmodule Alfred.Slack do
  use Slack

  alias Alfred.ApiAi.Api

  @token Application.get_env(:alfred, :slack)[:token]

  def start_link, do: start_link(@token, [])

  def handle_message(message = %{type: "message"}, slack, state) do
    handle_response(message, slack)
    {:ok, state ++ [message.text]}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end

  def handle_response(message, slack) do
    case Alfred.ApiAi.Api.query(message.text) do
      %{result: %{parameters: %{room: room, sensor: sensor}}} ->
        ExParticle.device_vars(Alfred.Particle.device_id, sensor)
        |> Alfred.Particle.handle_response
        |> send_message(message.channel, slack)
      %{result: %{fulfillment: %{speech: reply}}} ->
        send_message(reply, message.channel, slack)
      response -> IO.inspect response
    end
  end


end
