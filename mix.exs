defmodule Aoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "0.1.0",
      elixir: "~> 1.14",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:advent_of_code_utils, "~> 2.0"},
      {:benchee, "~> 1.0", only: :dev},
      {:heap, "~> 2.0"}
    ]
  end
end
