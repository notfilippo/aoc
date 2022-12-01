import AOC

aoc 2022, 1 do
  def p1 do
    input_string()
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n"))
    |> Enum.map(&Enum.reduce(&1, 0, fn(x, acc) -> acc + String.to_integer(x) end))
    |> Enum.max
  end

  def p2 do
    input_string()
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n"))
    |> Enum.map(&Enum.reduce(&1, 0, fn(x, acc) -> acc + String.to_integer(x) end))
    |> Enum.sort
    |> Enum.take(-3)
    |> Enum.sum
  end
end
