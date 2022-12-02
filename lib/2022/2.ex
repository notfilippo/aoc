import AOC

aoc 2022, 2 do
  @win %{r: :p, p: :s, s: :r}
  @draw Map.new(@win, fn {a, _} -> {a, a} end)
  @lose Map.new(@win, fn {a, b} -> {b, a} end)
  @outcome %{"X" => @lose, "Y" => @draw, "Z" => @win}
  @move_points %{r: 1, p: 2, s: 3}

  def to_rps(a) when a in ~w/A X/, do: :r
  def to_rps(a) when a in ~w/B Y/, do: :p
  def to_rps(a) when a in ~w/C Z/, do: :s

  # won
  def score({:s, :r}), do: 7
  def score({:r, :p}), do: 8
  def score({:p, :s}), do: 9

  # draw
  def score({a, a}), do: 3 + @move_points[a]

  # lost
  def score({_, b}), do: @move_points[b]

  def p1 do
    input_stream()
    |> Stream.map(&String.split(&1, " "))
    |> Stream.map(fn [opponent, outcome] ->
      {to_rps(opponent), to_rps(outcome)}
    end)
    |> Stream.map(&score/1)
    |> Enum.sum()
  end

  def p2 do
    input_stream()
    |> Stream.map(&String.split(&1, " "))
    |> Stream.map(fn [opponent, outcome] ->
      {to_rps(opponent), @outcome[outcome][to_rps(opponent)]}
    end)
    |> Stream.map(&score/1)
    |> Enum.sum()
  end
end
