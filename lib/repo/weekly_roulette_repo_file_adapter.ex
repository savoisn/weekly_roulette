defmodule WeeklyRoulette.Repo.FileAdapter do
  @behaviour WeeklyRoulette.Repo.Port

  def get_all_pixous() do
    path =
      Path.join(
        Application.get_env(:weekly_roulette, :conf_dir),
        Application.get_env(:weekly_roulette, :pixous_file)
      )

    read_json_file(Path.expand(path))
    |> get_users
  end

  def get_already_used_pixou() do
    path =
      Path.join(
        Application.get_env(:weekly_roulette, :conf_dir),
        Application.get_env(:weekly_roulette, :already_used)
      )

    path = Path.expand(path)
    file_exists_or_create(path)
    read_txt_file(path)
  end

  def save_used_pixou(pixou_name) do
    path =
      Path.expand(
        Path.join(
          Application.get_env(:weekly_roulette, :conf_dir),
          Application.get_env(:weekly_roulette, :already_used)
        )
      )

    {:ok, file} = File.open(path, [:append, {:delayed_write, 100, 20}])

    IO.binwrite(file, "\n#{pixou_name}")
    File.close(file)
  end

  def get_users({:ok, %{users: users}}) do
    users
    |> Enum.map(fn %{name: name} -> name end)
  end

  def get_users(_) do
    []
  end

  defp read_json_file(file_path) do
    with {:ok, content} <- File.read(file_path) do
      Jason.decode(content, keys: :atoms)
    end
  end

  defp read_txt_file(file_path) do
    with {:ok, content} <- File.read(file_path) do
      content
      |> String.split("\n", trim: true)
    end
  end

  defp file_exists_or_create(path) do
    if not File.exists?(path) do
      File.touch(path)
    end
  end
end
