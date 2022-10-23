defmodule WeeklyRoulette do
  @moduledoc """
  Documentation for `WeeklyRoulette`.
  """
  def calculate(users, already_used) when length(users) == length(already_used) do
    {:ko, :no_more_possibilities}
  end

  def calculate(users, already_used \\ []) do
    diff = users -- already_used
    Enum.random(diff)
  end
end
