defmodule WeeklyRoulette.Prompt.WebAdapter do
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

  def map_response(:yes), do: :ok
  def map_response(:no), do: :ko
end
