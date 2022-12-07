import AOC

aoc 2022, 6 do
  def p1 do
    input_string()
    |> String.graphemes()
    |> Stream.chunk_every(4, 1)
    |> Stream.with_index(4)
    |> Enum.find_value(fn {seq, i} ->
      if length(Enum.uniq(seq)) == 4, do: i, else: nil
    end)
  end

  def p2 do
    input_string()
    |> String.graphemes()
    |> Stream.chunk_every(14, 1)
    |> Stream.with_index(14)
    |> Enum.find_value(fn {seq, i} ->
      if length(Enum.uniq(seq)) == 14, do: i, else: nil
    end)
  end
end
