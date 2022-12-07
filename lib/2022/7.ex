import AOC

aoc 2022, 7 do
  def execute("$ cd /", {_, files}), do: {[], files}
  def execute("$ cd ..", {cwd, files}), do: {Enum.drop(cwd, -1), files}
  def execute("$ cd " <> dir, {cwd, files}), do: {cwd ++ [dir], files}
  def execute("$ ls", {cwd, files}), do: {cwd, files}

  def execute("dir " <> dir, {cwd, files}) do
    {cwd, Map.put(files, cwd ++ [dir], 0)}
  end

  def execute(file, {cwd, files}) do
    [size, name] = String.split(file)
    {cwd, Map.put(files, cwd ++ [name], String.to_integer(size))}
  end

  def size(files, prefix) do
    files
    |> Map.filter(fn {path, _} -> List.starts_with?(path, prefix) end)
    |> Map.values()
    |> Enum.sum()
  end

  def size_of_directories(files) do
    files
    |> Enum.filter(fn {_, size} -> size == 0 end)
    |> Enum.map(fn {path, _} -> size(files, path) end)
  end

  def p1 do
    input_stream()
    |> Enum.reduce({{}, %{[] => 0}}, &execute/2)
    |> elem(1)
    |> size_of_directories()
    |> Enum.filter(fn size -> size <= 100_000 end)
    |> Enum.sum()
  end

  def p2 do
    files =
      input_stream()
      |> Enum.reduce({{}, %{[] => 0}}, &execute/2)
      |> elem(1)

    root_size = size(files, [])

    files
    |> size_of_directories()
    |> Enum.filter(fn size -> size >= 30_000_000 - (70_000_000 - root_size) end)
    |> Enum.min()
  end
end
