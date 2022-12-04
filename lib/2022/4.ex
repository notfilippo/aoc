import AOC

aoc 2022, 4 do
  def parse(line) do
    line
    |> String.split(~r/-|,/)
    |> Enum.map(&String.to_integer/1)
  end

  def p1 do
    input_stream()
    |> Stream.map(&parse/1)
    |> Stream.filter(fn [a, b, c, d] -> (a <= c and b >= d) or (a >= c and b <= d) end)
    |> Enum.count()
  end

  def p2 do
    input_stream()
    |> Stream.map(&parse/1)
    |> Stream.filter(fn [a, b, c, d] -> not (b < c or a > d) end)
    |> Enum.count()
  end
end
