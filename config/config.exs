# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :tech_phone, TechPhone.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "tech_phone_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"


# Configures the endpoint
config :tech_phone, TechPhone.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "R0iIfS2x9O9QKHrg2++hk38sgCWExpWwq3wwxyRZuzobG+sXaZYUpv5Ap9CU5j40",
  signing_salt: "WePVIPqM",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: TechPhone.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :tech_phone,
  audio_cdn: System.get_env("AUDIO_CDN"),
  mail_from: System.get_env("MAIL_FROM"),
  mail_to: System.get_env("MAIL_TO")

config :tech_phone, :mailgun,
  domain: System.get_env("MAILGUN_DOMAIN"),
  key: System.get_env("MAILGUN_API_KEY")

config :tech_phone, :twilio,
  account: System.get_env("ACCOUNT_SID"),
  key: System.get_env("API_KEY"),
  secret: System.get_env("API_SECRET")

# config :tech_phone,
#   mg_domain: System.get_env("MAILGUN_DOMAIN"),
#   mg_key: System.get_env("MAILGUN_API_KEY"),
#
# config :tech_phone,
#   twilio_account: System.get_env("TWILIO_ACCOUNT_SID"),
#   twilio_key: System.get_env("TWILIO_API_KEY"),
#   twilio_secret: System.get_env("TWILIO_API_SECRET")
