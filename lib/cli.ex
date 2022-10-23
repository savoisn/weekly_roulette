defmodule WeeklyRoulette.CLI do
  def main(args) do
    options = [
      switches: [config_dir: :string, user_file: :string, already_used: :string, help: :boolean],
      aliases: [d: :config_dir, u: :user_file, a: :already_used]
    ]

    {opts, _, _} = OptionParser.parse(args, options)
    config_dir = opts[:config_dir] || Application.get_env(:weekly_roulette, :conf_dir)
    Application.put_env(:weekly_roulette, :conf_dir, config_dir)
    users_file = opts[:user_file] || Application.get_env(:weekly_roulette, :pixous_file)
    Application.put_env(:weekly_roulette, :pixous_file, users_file)
    already_used = opts[:already_used] || Application.get_env(:weekly_roulette, :already_used)
    Application.put_env(:weekly_roulette, :already_used, already_used)

    banner = ~S"""
    __        __        _    _         ____
    \ \      / /__  ___| | _| |_   _  |  _ \  _____   __
     \ \ /\ / / _ \/ _ \ |/ / | | | | | | | |/ _ \ \ / /
      \ V  V /  __/  __/   <| | |_| | | |_| |  __/\ V /
       \_/\_/ \___|\___|_|\_\_|\__, | |____/ \___| \_/
                                |___/
    """

    IO.puts(banner)

    WeeklyRoulette.UseCases.start()
  end
end
