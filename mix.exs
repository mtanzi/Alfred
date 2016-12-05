defmodule Alfred.Mixfile do
  use Mix.Project

  def project do
    [app: :alfred,
     version: "0.1.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :slack, :httpoison, :exparticle],
     mod: {Alfred, []}]
  end

  defp deps do
    [{:slack, "~> 0.9.0"},
     {:httpoison, "~> 0.10.0", override: true},
     {:poison, "~> 3.0.0", },
     {:exparticle, "~> 0.0.6"},
     {:websocket_client, git: "https://github.com/jeremyong/websocket_client", override: true}]
  end
end
