defmodule Alfred.Particle do

  def handle_response(%ExParticle.Model.DeviceVariable{name: name, result: result}) do
    "the #{name} is #{result}"
  end

  def handle_response(response) do
    "data not available"
  end

  def device_id do
    config = Application.get_env(:exparticle, :api)
    Dict.get(config, :device_id)
  end

end
