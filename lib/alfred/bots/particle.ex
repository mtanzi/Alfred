defmodule Alfred.Bots.Particle do
  @moduledoc """
    This bot use the Particle.io web API to  retrive the temperature the humidity
    and the dust bensity mesured by the sensors connected to the device.
    We access the Particle.io API using the module ExParticle

    ex:
    ```
      ExParticle.device_vars(device_id, "temperature")
    ```

  """
  use Slack

  @behaviour Alfred.Bot

  def parse_message(%{result: %{parameters: %{room: room, sensor: sensor}}}, message, slack) do
    ExParticle.device_vars(device_id, map_sensor(sensor))
    |> handle_response
    |> send_message(message.channel, slack)
  end

  def handle_response(%ExParticle.Model.DeviceVariable{name: name, result: result}) do
    "the #{name} is #{result}"
  end

  def handle_response(response) do
    "data not available"
  end

  def map_sensor("temperature"), do: "temperature"
  def map_sensor("humidity"), do: "humidity"
  def map_sensor("dust density"), do: "dust_density"

  def device_id do
    config = Application.get_env(:exparticle, :api)
    Dict.get(config, :device_id)
  end
end
