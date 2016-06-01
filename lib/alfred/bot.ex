defmodule Alfred.Bot do
  @moduledoc """
    This behavior is created to defines new Bots.

    ## Example
    ```
    defmodule EchoBot do
      use Slack
      @behaviour Alfred.Bot

      def parse_message(resp, message, slack) do
        send_message(message.text, slack)
      end
    end
    ```
  """

  @callback parse_message(Map.t, Map.t, Map.t) :: any
end
