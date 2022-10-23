defmodule WeeklyRoulette.Repo.Port do
  @callback get_all_pixous :: [Pixou]

  @callback get_already_used_pixou() :: [Pixou]

  @callback save_used_pixou(Pixou) :: Pixou
end
