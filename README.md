# Alfred

Slack bot that leverage the power of Api.ai to understand the message sent and process it accordingly

The bot supported at the moment are:
* [TFL](https://api.tfl.gov.uk/)
* [Particle.io](https://docs.particle.io/reference/api/) using [exparticle](https://github.com/mtanzi/exparticle)
* Jenkins (WIP)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add alfred to your list of dependencies in `mix.exs`:
    ```elixir
      def deps do
        [{:alfred, "~> 0.0.1"}]
      end
    ```

  2. Ensure alfred is started before your application:
    ```elixir
      def application do
        [applications: [:alfred]]
      end
    ```

You need to add the following environment variables in order to setup Alfred

* Slack token
  ```bash
  export SLACK_BOT_TOKEN=**token**
  ```

* Api.Ai credentials
  ```bash
  export API_AI_TOKEN=**token**
  export API_AI_KEY=**key**
  ```

Bot variables:

* Particle.io
  ```bash
  export PARTICLE_TOKEN=**token**
  export PARTICLE_DEVICE_ID=**devise_id**
  ```

* TFL api
  ```bash
  export TFL_APP_ID=**app_id**
  export TFL_APP_KEY=**app_key**
  ```
