import AOC

aoc 2015, 1 do
  def p1 do
    input_string()
    |> String.graphemes()
    |> Stream.map(fn c -> case c do "(" -> 1; ")" -> -1 end end)
    |> Enum.sum()
  end

  def p2 do
    input_string()
    |> String.graphemes()
    |> Stream.map(fn c -> case c do "(" -> 1; ")" -> -1 end end)
    |> Stream.with_index()
    |> Enum.reduce_while(0, fn {a, i}, acc ->
      if acc == -1, do: {:halt, i}, else: {:cont, acc + a}
    end)
  end
end
