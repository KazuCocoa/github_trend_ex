defmodule GithubTrendEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :github_trend_ex,
      version: "0.2.0",
      elixir: "~> 1.3",
      name: "GithubTrendEx",
      source_url: "https://github.com/KazuCocoa/github_trend_ex",
      description: "Get trend repositories from Github.",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [applications: [:httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:hackney, "1.6.3"},
      {:floki, "~> 0.12.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md LICENSE),
      maintainers: ["Kazuaki Matsuo"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/KazuCocoa/github_trend_ex"}
    ]
  end
end
