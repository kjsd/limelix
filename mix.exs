defmodule Limelix.MixProject do
  use Mix.Project

  @description"""
  LIne MEssaging platform on ELIXer.
  """

  def project do
    [
      app: :limelix,
      version: "0.1.0",
      elixir: "~> 1.14",
      description: @description,
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end


  def package do
    [
      maintainers: ["kjsd"],
      licenses: ["BSD-2-Clause license"],
      links: %{ "Github": "https://github.com/kjsd/limelix" }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Limelix.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:line_developers, "~> 0.1.0"},
      {:rpcsdk, "~> 0.1.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
