import AOC

aoc 2022, 10 do
  def execute("noop", [last | _] = cycles), do: [last | cycles]

  def execute("addx " <> x, [last | _] = cycles),
    do: [last + String.to_integer(x) | execute("noop", cycles)]

  def p1 do
    input_stream()
    |> Enum.reduce([1], &execute/2)
    |> Enum.reverse()
    |> Enum.with_index(&{&2 + 1, &1})
    |> Enum.slice(19..-1//1)
    |> Enum.take_every(40)
    |> Enum.reduce(0, &(&2 + elem(&1, 0) * elem(&1, 1)))
  end

  def p2 do
    input_stream()
    |> Enum.reduce([1], &execute/2)
    |> Enum.reverse()
    |> Enum.chunk_every(40)
    |> Enum.map(fn row ->
      row |> Enum.with_index(&{&2, &1})
    end)
    |> Enum.map(
      &Enum.reduce(&1, "", fn {position, register}, output ->
        cond do
          position in (register - 1)..(register + 1) -> output <> "#"
          true -> output <> "."
        end
      end)
    )
    # remove the extra noop offset we'd added at the start
    |> Enum.drop(-1)
  end
end
