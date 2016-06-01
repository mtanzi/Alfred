defmodule Alfred.Bots.Echo do
  @behaviour Alfred.Bot

  def parse_message(_resp, message, slack) do
    send_message("cool story bro!", message.channel, slack)
  end
end
