import AOC

aoc 2015, 2 do
  def p1 do
    input_stream()
    |> Stream.map(&String.split(&1, "x"))
    |> Stream.map(fn dimensions ->
      [w, h, l] = dimensions |> Enum.map(&String.to_integer/1) |> Enum.sort()
      2 * l * w + 2 * w * h + 2 * h * l + w * h
    end)
    |> Enum.sum()
  end

  def p2 do
    input_stream()
    |> Stream.map(&String.split(&1, "x"))
    |> Stream.map(fn dimensions ->
      [w, h, l] = dimensions |> Enum.map(&String.to_integer/1) |> Enum.sort()
      2 * w + 2 * h + w * h * l
    end)
    |> Enum.sum()
  end
end
