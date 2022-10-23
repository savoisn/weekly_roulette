import Config

config :weekly_roulette,
  conf_dir: "~/.config/weekly-roulette",
  pixous_file: "pixous.json",
  already_used: "already_used_pixous.txt",
  repo_adapter: WeeklyRoulette.Repo.FileAdapter,
  prompt_adapter: WeeklyRoulette.Prompt.CliAdapter

import_config "#{Mix.env()}.exs"
