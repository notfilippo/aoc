import AOC

aoc 2015, 3 do
  def move("^", {x, y}), do: {x, y+1}
  def move("v", {x, y}), do: {x, y-1}
  def move(">", {x, y}), do: {x+1, y}
  def move("<", {x, y}), do: {x-1, y}

  def deliver([c | rest]) do
    deliver([c | rest], {0, 0}, MapSet.new([{0, 0}]))
  end

  def deliver([c | rest], pos, set) do
    next_pos = move(c, pos)
    deliver(rest, next_pos, MapSet.put(set, next_pos))
  end

  def deliver([], _, set), do: set

  def p1 do
    input_string()
    |> String.graphemes()
    |> deliver()
    |> MapSet.size()
  end

  def p2 do
    santa =
      input_string()
      |> String.graphemes()
      |> Enum.take_every(2)
      |> deliver()
    robot =
      input_string()
      |> String.graphemes()
      |> Enum.drop(1)
      |> Enum.take_every(2)
      |> deliver()

    MapSet.union(santa, robot)
    |> MapSet.size()
  end
end
