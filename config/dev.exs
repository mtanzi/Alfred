use Mix.Config

config :alfred, :bots,
  list: [ %{"tfl" => Alfred.Bots.TFL},
          %{"jenkins" => Alfred.Bots.Jenkins},
          %{"particle" => Alfred.Bots.Particle},
        ]

config :alfred, :tfl,
  base_url: "https://api.tfl.gov.uk",
  app_id: System.get_env("TFL_APP_ID"),
  app_key: System.get_env("TFL_APP_KEY")

config :alfred, :jenkins,
  user: System.get_env("JENKINS_USER"),
  pass: System.get_env("JENKINS_PASS"),
  base_url: "http://euwest1-mgmt-core",
  port: 8080

config :alfred, :slack,
  token: System.get_env("SLACK_BOT_TOKEN")

config :alfred, :api_ai,
  access_token: System.get_env("API_AI_TOKEN"),
  subscription_key: System.get_env("API_AI_KEY"),
  base_url: "https://api.api.ai/v1",
  listener_timeout: 20000

config :exparticle, :api,
  access_token: System.get_env("PARTICLE_TOKEN"),
  device_id: System.get_env("PARTICLE_DEVICE_ID")
