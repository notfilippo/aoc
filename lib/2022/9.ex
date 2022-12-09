import AOC

aoc 2022, 9 do
  def move("R " <> off, {x, y}),
    do: Enum.zip((x + 1)..(x + String.to_integer(off)), List.duplicate(y, String.to_integer(off)))

  def move("L " <> off, {x, y}),
    do: Enum.zip((x - 1)..(x - String.to_integer(off)), List.duplicate(y, String.to_integer(off)))

  def move("U " <> off, {x, y}),
    do: Enum.zip(List.duplicate(x, String.to_integer(off)), (y + 1)..(y + String.to_integer(off)))

  def move("D " <> off, {x, y}),
    do: Enum.zip(List.duplicate(x, String.to_integer(off)), (y - 1)..(y - String.to_integer(off)))

  def path(m, positions) do
    positions ++ move(m, List.last(positions))
  end

  def sign(0), do: 0
  def sign(n) when n > 0, do: 1
  def sign(n) when n < 0, do: -1

  def next({hx, hy}, {tx, ty}) do
    case {hx - tx, hy - ty} do
      {2, 0} ->
        {tx + 1, ty}

      {-2, 0} ->
        {tx - 1, ty}

      {0, 2} ->
        {tx, ty + 1}

      {0, -2} ->
        {tx, ty - 1}

      {x, y} when (x == 0 or y == 0) or (abs(x) == 1 and abs(y) == 1) ->
        {tx, ty}

      _ ->
        {ox, oy} = {sign(hx - tx), sign(hy - ty)}
        {tx + ox, ty + oy}
    end
  end

  def follow(head, {tails, set}) do
    new =
      [head | tails]
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] -> next(a, b) end)

    {new, MapSet.put(set, List.last(new))}
  end

  def p1 do
    input_stream()
    |> Enum.reduce([{0, 0}], &path/2)
    |> Enum.reduce({[{0, 0}], MapSet.new([{0, 0}])}, &follow/2)
    |> elem(1)
    |> MapSet.size()
  end

  def p2 do
    input_stream()
    |> Enum.reduce([{0, 0}], &path/2)
    |> Enum.reduce({List.duplicate({0, 0}, 9), MapSet.new([{0, 0}])}, &follow/2)
    |> elem(1)
    |> MapSet.size()
  end
end
