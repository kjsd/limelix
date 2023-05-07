import Config

config :line_developers,
  messaging_api: LINEDevelopers.MessagingAPIStub

# Print only warnings and errors during test
config :logger, level: :warn
