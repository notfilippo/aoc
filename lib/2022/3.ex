import AOC

aoc 2022, 3 do
  def priority([c]) do
    <<v::utf8>> = c

    if c == String.upcase(c) do
      26 + v - 64
    else
      v - 96
    end
  end

  def common(graphemes) do
    graphemes
    |> Enum.map(&Enum.into(&1, MapSet.new()))
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()
  end

  def p1 do
    input_stream()
    |> Stream.map(&String.graphemes/1)
    |> Stream.map(fn line -> Enum.chunk_every(line, div(length(line), 2)) end)
    |> Stream.map(&common/1)
    |> Stream.map(&priority/1)
    |> Enum.sum()
  end

  def p2 do
    input_stream()
    |> Stream.map(&String.graphemes/1)
    |> Stream.chunk_every(3)
    |> Stream.map(&common/1)
    |> Stream.map(&priority/1)
    |> Enum.sum()
  end
end
