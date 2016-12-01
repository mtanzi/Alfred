defmodule Alfred.Base do
  use Slack
  require Logger

  alias Alfred.ApiAi.Api
  alias Alfred.Bots.Particle

  @doc "Handle and print connection details."
  def handle_message(_message = %{type: "hello"}, slack, state) do
    Logger.info("Connected to #{slack.team.domain} as #{slack.me.name}")
    {:ok, state}
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    handle_response(message, slack)
    {:ok, state ++ [message.text]}
  end

  def handle_message(_message = %{type: type}, _slack, state) do
    Logger.info("message type #{type}")
    {:ok, state}
  end

  def handle_response(message, slack) do
    Logger.info("message.text: #{message.text}")
    parse_message(Alfred.ApiAi.Api.query(message.text), message, slack)
  end

  def parse_message(%{result: %{parameters: %{bot: bot}}} = response, message, slack) do
    bots
    |> Enum.find(fn(x) -> Map.get(x, bot) end)
    |> Enum.each(fn({bot_id, bot}) -> call_bot(bot, response, message, slack) end)
  end

  defp call_bot(bot, response, message, slack) do
    IO.inspect bot
    spawn fn -> bot.parse_message(response, message, slack) end
  end

  def bots do
    Application.get_env(:alfred, :bots)
    |> Dict.get(:list)
  end

  def parse_message(response, message, slack), do: Logger.info "response"
end
