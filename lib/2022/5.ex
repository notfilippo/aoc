import AOC

aoc 2022, 5 do
  def parse([stacks_string, instructions_string]) do
    stacks = stacks_string
    |> String.replace(~r"\[|\]", " ")
    |> String.split("\n")
    |> Enum.reverse() # skip last
    |> tl()
    |> Enum.reverse()
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.drop(1)
      |> Enum.chunk_every(1, 4)
      |> List.flatten()
    end)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.with_index(1)
    |> Map.new(fn {list, i} -> {i, Enum.filter(list, fn c -> c != " " end)} end)

    instructions = for instruction <- String.split(instructions_string, "\n") do
      [_ | matches] = Regex.run(~r/move (\d+) from (\d+) to (\d+)/, instruction)
      Enum.map(matches, &String.to_integer/1)
    end

    [stacks, instructions]
  end

  def execute([stacks, instructions], lift_multiple \\ true) do
    instructions
    |> Enum.reduce(stacks, fn [quantity, from, to], stacks ->
      {m, u} = Enum.split(stacks[from], quantity)
      %{stacks | from => u, to => ((lift_multiple && m) || Enum.reverse(m)) ++ stacks[to]}
    end)
    |> Enum.map_join(fn {_, [first | _]} -> first end)
  end

  def p1 do
      input_string()
      |> String.split("\n\n")
      |> parse()
      |> execute(false)
  end

  def p2 do
    input_string()
    |> String.split("\n\n")
    |> parse()
    |> execute(true)
  end
end
