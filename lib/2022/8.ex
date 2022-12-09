import AOC

aoc 2022, 8 do
  def p1 do
    grid =
      input_stream()
      |> Enum.map(fn line ->
        line
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)
      end)

    size = length(grid)
    points = for row <- 0..(size - 1), col <- 0..(size - 1), do: {row, col}

    points
    |> Enum.filter(&visible?(grid, &1, size))
    |> Enum.count()
  end

  def p2 do
    matrix =
      input_stream()
      |> Enum.map(fn line ->
        line
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)
      end)

    size = length(matrix)
    points = for row <- 0..(size - 1), col <- 0..(size - 1), do: {row, col}

    points
    |> Enum.filter(fn {x, y} -> x > 0 and y > 0 and x < size - 1 and y < size - 1 end)
    |> Enum.map(fn p -> scenic_score({matrix, size}, p) end)
    |> Enum.max()
  end

  def visible?(grid, {row, col} = point, size) do
    if col == 0 or row == 0 or col == size - 1 or row == size - 1 do
      true
    else
      inner_visible?(grid, point, size)
    end
  end

  def inner_visible?(grid, {row, col} = point, size) do
    height = at(grid, point)
    left = Enum.all?(0..(col - 1), fn i -> at(grid, {row, i}) < height end)
    right = Enum.all?(min(col + 1, size - 1)..(size - 1), fn i -> at(grid, {row, i}) < height end)
    up = Enum.all?(0..(row - 1), fn i -> at(grid, {i, col}) < height end)
    down = Enum.all?(min(row + 1, size - 1)..(size - 1), fn i -> at(grid, {i, col}) < height end)

    left or right or up or down
  end

  defp scenic_score({matrix, size}, {x, y}) do
    current_height = at(matrix, {x, y})

    left =
      (x - 1)..0
      |> Stream.map(&at(matrix, {&1, y}))
      |> scenic_score_dir(current_height)

    right =
      min(x + 1, size - 1)..(size - 1)
      |> Stream.map(&at(matrix, {&1, y}))
      |> scenic_score_dir(current_height)

    up =
      (y - 1)..0
      |> Stream.map(&at(matrix, {x, &1}))
      |> scenic_score_dir(current_height)

    down =
      min(y + 1, size - 1)..(size - 1)
      |> Stream.map(&at(matrix, {x, &1}))
      |> scenic_score_dir(current_height)

    left * right * up * down
  end

  defp scenic_score_dir(heights, current_height) do
    Enum.reduce_while(heights, 0, fn x, trees ->
      if x >= current_height, do: {:halt, trees + 1}, else: {:cont, trees + 1}
    end)
  end

  def at(grid, {row, col}) do
    grid |> Enum.at(row) |> Enum.at(col)
  end
end
