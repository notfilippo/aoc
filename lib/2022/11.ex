import AOC

aoc 2022, 11 do
  defmodule Monkey do
    defstruct num: -1, items: [], op: &Function.identity/1, divisor: 0, yes: -1, no: -1, times: 0

    def parse(lines) do
      [
        "Monkey " <> <<mnum::bytes-size(1)>> <> ":",
        "Starting items: " <> starts,
        "Operation: new = " <> oper,
        "Test: divisible by " <> divisor,
        "If true: throw to monkey " <> yesnum,
        "If false: throw to monkey " <> nonum
      ] = lines

      op =
        case oper do
          "old + old" -> &(&1 + &1)
          "old * old" -> &(&1 * &1)
          "old + " <> arg -> &(&1 + String.to_integer(arg))
          "old * " <> arg -> &(&1 * String.to_integer(arg))
        end

      %Monkey{
        num: String.to_integer(mnum),
        items: Enum.map(String.split(starts, ", "), &String.to_integer/1),
        op: op,
        divisor: String.to_integer(divisor),
        yes: String.to_integer(yesnum),
        no: String.to_integer(nonum)
      }
    end

    def parse_several(input) do
      chunk_fun = fn
        "", acc -> {:cont, acc, []}
        x, acc -> {:cont, acc ++ [x]}
      end

      acc_fun = fn
        [] -> {:cont, []}
        acc -> {:cont, acc, acc}
      end

      input
      |> Enum.chunk_while([], chunk_fun, acc_fun)
      |> Enum.map(&parse/1)
      |> Enum.with_index()
      |> Enum.map(fn {m, _} -> m end)
      |> List.to_tuple()
    end
  end

  defp solve(monkeys, rounds, adjust_worry_fun) do
    Enum.reduce(1..rounds, monkeys, fn _, ms -> play_round(ms, adjust_worry_fun) end)
    |> Tuple.to_list()
    |> Enum.map(& &1.times)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  def play_round(monkeys, worry_fun) do
    Enum.reduce(0..(tuple_size(monkeys) - 1), monkeys, &play_turn(&1, &2, worry_fun))
  end

  def play_turn(who, monkeys, worry_fun) do
    Enum.reduce(elem(monkeys, who).items, monkeys, fn item, acc ->
      m = elem(acc, who)
      level = worry_fun.(m.op.(item))
      next = if rem(level, m.divisor) == 0, do: m.yes, else: m.no
      next_m = elem(acc, next)

      put_elem(
        put_elem(acc, next, struct!(next_m, items: next_m.items ++ [level])),
        who,
        struct!(m, times: m.times + 1, items: tl(m.items))
      )
    end)
  end

  def p1 do
    monkeys =
      input_stream()
      |> Monkey.parse_several()

    solve(monkeys, 20, &div(&1, 3))
  end

  def p2 do
    monkeys =
      input_stream()
      |> Monkey.parse_several()

    lcm = monkeys |> Tuple.to_list() |> Enum.map(& &1.divisor) |> Enum.product()
    solve(monkeys, 10_000, &rem(&1, lcm))
  end
end
