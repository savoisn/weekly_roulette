defmodule WeeklyRoulette.Repo.FileAdapterTest do
  use ExUnit.Case

  test "read json file" do
    pixous = WeeklyRoulette.Repo.FileAdapter.get_all_pixous()

    users = [
      "Nicolas Savois",
      "Melanie Boudard",
      "Thierry Loesch",
      "Mickael Alibert",
      "Francois De Metz",
      "Pierre Top"
    ]

    assert pixous == users
  end

  test "read_txt_file" do
    already_used_pixou = WeeklyRoulette.Repo.FileAdapter.get_already_used_pixou()

    validate = ["Pierre Top", "Thierry Loesch"]

    assert already_used_pixou == validate
  end
end
