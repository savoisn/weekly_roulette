defmodule WeeklyRoulette.Prompt.CliAdapter do
  @behaviour WeeklyRoulette.Prompt.Port

  def validate_willing_pixou({:ko, :no_more_possibilities}) do
    {:ko, :no_more_possibilities}
  end

  def validate_willing_pixou(username) do
    response =
      Prompt.confirm("#{username} pret pour le presenter le weekly",
        default_answer: :no
      )

    map_response(response)
  end

  def show_waiting(pixous, time \\ 2, sleep_time \\ 100) do
    nb_iter = trunc(time * 1000 / 100)

    Enum.each(1..nb_iter, fn i ->
      escape =
        if i == 1 do
          ""
        else
          "\e[F"
        end

      IO.write("#{escape}#{Enum.random(pixous)}             \n")
      Process.sleep(sleep_time)
    end)

    IO.write("\e[F")
  end

  def map_response(:yes), do: :ok
  def map_response(:no), do: :ko
end
