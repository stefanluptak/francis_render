import Config

config :francis_render, db_password: System.fetch_env!("DB_PASSWORD")
