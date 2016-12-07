defmodule Alfred.Bots.Jenkins do
  @moduledoc """
    TODO: Bot still under development

  """

  use Slack

  @behaviour Alfred.Bot

  require Logger

  def id, do: "jenkins"

  def parse_message(%{result: %{parameters: %{clients: client}}}, message, slack) do
    if client != "" do
      user = slack.users[message.user].real_name
      res = api_post(client)
      send_message("#{user} #{res.message}", message.channel, slack)
    else
      send_message("The client does not exist.", message.channel, slack)
    end
  end

  alias Alfred.Config

  # curl -X POST http://euwest1-mgmt-core:8080/job/JOB_NAME/buildWithParameters?token=TOKEN \
  #   --user USER:PASSWORD \
  #   --form file0=@PATH_TO_FILE \
  #   --form json='{"parameter": [{"name":"FILE_LOCATION_AS_SET_IN_JENKINS", "file":"file0"}]}'

  def api_post(client) do
    auth = [hackney: [basic_auth: {user, pass}]]
    data = {:form, [json: (%{parameters: ""} |> Poison.encode!)]}

    "/job/#{map_job_name(client)}/buildWithParameters?token=ninJakopcosFaksOzDoc"
    |> do_post(data, [], auth)
  end

  def do_post(url_part, data \\ "", params \\ [], options \\ []) do

    "#{url}:#{port}#{url_part}"
    |> HTTPoison.post!(data, params, options)
    |> handle_response
  end

  def map_job_name("my_meds"), do: "STG_M3_MYMEDS"
  def map_job_name("aa_pharma"), do: "STG_M3_AAPHARMA"
  def map_job_name("mmm_pharma"), do: "STG_M3_MMM_PHARMA"
  def map_job_name("pfizer"), do: "STG_M3_PFIZER"
  def map_job_name("allergan"), do: "STG_M3_ALLERGAN"

  defp handle_response(%HTTPoison.Response{body: body, status_code: status_code}) do
    case status_code do
      201 ->
        %{code: status_code, message: "Started deploy"}
      _ ->
        %{code: status_code, message: "Deploy didn't start."}
    end
  end

  defp build_url([part, []]) do
   "#{url}:#{port}#{part}"
  end
  defp build_url([part, params]) do
    "#{url}:#{port}#{part}?#{params_join(params)}"
  end

  defp params_join(params) do
    params_join(params, "")
  end
  defp params_join([h | []], string) do
    [param, value] = h
    string <> "&#{param}=#{value}"
  end
  defp params_join([h | t], "") do
    [param | value] = h
    params_join(t, "#{param}=#{value}")
  end
  defp params_join([h | t], string) do
    [param | value] = h
    params_join(t, string<>"&#{param}=#{value}")
  end

  defp url do
    Application.get_env(:alfred, :jenkins)
    |> Dict.get(:base_url)
  end

  defp port do
    Application.get_env(:alfred, :jenkins)
    |> Dict.get(:port)
  end

  defp user do
    Application.get_env(:alfred, :jenkins)
    |> Dict.get(:user)
  end

  defp pass do
    Application.get_env(:alfred, :jenkins)
    |> Dict.get(:pass)
  end
end
