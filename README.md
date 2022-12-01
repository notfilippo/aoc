# AoC Solutions

> Learning elixir by solving Advent of Code problems

## Usage

First off, download all the dependencies:

```bash
mix deps.get
```

Then create a file called `config.exs` in the `config` directory, by copying the `config_example.exs` file. Uncomment the code and add your AoC session token.

Then enter into the interactive elixir REPL:

```bash
iex -S mix
```

## Running the tests

```elixir
# run part one
p1 <year> <day>
# or part two
p2 <year> <day>
```

## Reference

For more info on Advent of Code, see [here](https://adventofcode.com/). I've also used the `advent_of_code_utils` package, which can be found [here](https://github.com/mathsaey/advent_of_code_utils).

## License

MIT