defmodule WeeklyRouletteTest do
  use ExUnit.Case

  doctest WeeklyRoulette

  test "random name is part of the users" do
    users = [
      "Nicolas Savois",
      "Melanie Boudard",
      "Thierry Loesch",
      "Mickael Alibert",
      "Francois De Metz",
      "Pierre Top"
    ]

    user_obtained = WeeklyRoulette.calculate(users)
    assert Enum.member?(users, user_obtained)
  end

  test "random name is part of the users and not part of the already passed name" do
    already_used = ["Pierre Top", "Thierry Loesch"]

    users = [
      "Thierry Loesch",
      "Francois De Metz",
      "Pierre Top"
    ]

    user_obtained = WeeklyRoulette.calculate(users, already_used)

    assert Enum.member?(users, user_obtained)
    refute Enum.member?(already_used, user_obtained)
    assert user_obtained == "Francois De Metz"
  end

  test "validate user to already_used file" do
  end

  def get_users({:ok, %{users: users}}) do
    users
    |> Enum.map(fn %{name: name} -> name end)
  end

  def get_users(_) do
    []
  end

  def read_json_file(file_path) do
    with {:ok, content} <- File.read(file_path) do
      Jason.decode(content, keys: :atoms)
    end
  end

  def read_txt_file(file_path) do
    with {:ok, content} <- File.read(file_path) do
      content
      |> String.split("\n")
    end
  end
end
