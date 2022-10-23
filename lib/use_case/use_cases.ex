defmodule WeeklyRoulette.UseCases do
  @repo Application.compile_env(:weekly_roulette, :repo_adapter)
  @prompt Application.compile_env(:weekly_roulette, :prompt_adapter)

  def start() do
    pixous = @repo.get_all_pixous()
    already_used = @repo.get_already_used_pixou()
    pixou = get_one_willing_pixou(pixous, already_used)
    terminate(pixou)
  end

  def terminate({:ko, :no_more_possibilities}) do
    IO.puts("No more possibilities")
  end

  def terminate(pixou) do
    @repo.save_used_pixou(pixou)
    IO.puts("Pixou choisi : #{pixou} Merci !")
    IO.puts("#{pixou} a ete ajouter a la liste des 'deja passes' !")
  end

  defp get_one_willing_pixou(pixous, already_used) do
    get_one_willing_pixou(pixous, already_used, nil, :ko)
  end

  defp get_one_willing_pixou(_, _, _, {:ko, :no_more_possibilities}) do
    {:ko, :no_more_possibilities}
  end

  defp get_one_willing_pixou(pixous, already_used, willing_pixou, :ko) do
    @prompt.show_waiting(pixous)
    pixou = WeeklyRoulette.calculate(pixous, already_used)
    response = @prompt.validate_willing_pixou(pixou)
    get_one_willing_pixou(pixous, already_used ++ [willing_pixou], pixou, response)
  end

  defp get_one_willing_pixou(pixous, already_used, willing_pixou, :ok) do
    willing_pixou
  end
end
