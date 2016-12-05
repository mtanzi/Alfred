defmodule Alfred.Mixfile do
  use Mix.Project

  def project do
    [app: :alfred,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :slack, :httpoison, :exparticle,
                    :websocket_client, :poison],
     mod: {Alfred, []}]
  end

  defp deps do
    [{:slack, "~> 0.4.2"},
     {:httpoison, "~> 0.8.0"},
     {:poison, "~> 1.5"},
     {:exparticle, "~> 0.0.2"},
     {:distillery, "~> 1.0.0"},
     {:websocket_client, git: "https://github.com/jeremyong/websocket_client"}]
  end
end
