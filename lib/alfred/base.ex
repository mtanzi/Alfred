defmodule Alfred.Base do
  @moduledoc """
    Thge Base module receive the message coming from Slack and send it to Api.ai
    to have a better understanding on which bot the user want to interact to.
    When the response return from Api.ai the message will be adressed to the
    correct bot, processed and sent back to Slack.

    The list of bots available is defined inside the config file
    ```
      config :alfred, :bots,
        list: [ Alfred.Bots.TFL,
                Alfred.Bots.Jenkins,
                Alfred.Bots.Particle,
              ]
    ```
  """

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

  def parse_message(%{result: %{parameters: %{bot: [bot_id]}}} = response, message, slack) do
    bots
    |> Enum.find(fn(bot) -> bot.id == bot_id end)
    |> call_bot(response, message, slack)
  end

  defp call_bot(bot, response, message, slack) do
    spawn fn -> bot.parse_message(response, message, slack) end
  end

  def bots do
    Application.get_env(:alfred, :bots)
    |> Dict.get(:list)
  end

  def parse_message(response, message, slack), do: Logger.info "response"
end
