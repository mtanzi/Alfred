defmodule Alfred.ApiAi.Api do
  import Alfred.ApiAi.Base

  def query(text) do
    data = %{
      query: [text],
      lang: "en",
      sessionId: "alfred-test"
    }

    post("/query?v=20150910", Poison.encode!(data))
  end
end
