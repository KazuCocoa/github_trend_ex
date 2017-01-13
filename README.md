# GithubTrendEx

Get trend repositories from Github.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add current_streak_ex to your list of dependencies in `mix.exs`:

        def deps do
          [{:github_trend_ex, "~> 0.2.0"}]
        end

# How to use

```elixir
iex> GithubTrendEx.trend |> GithubTrendEx.list
[%GithubTrendEx.Repo{contributors: ["dularion", "JanneNiemela",
   "LorenzoGarbanzo", "jsniemela", "DanielNowak1986"],
  description: "It's like Netflix, but self-hosted! http://dularion.github.io/streama/",
  forks: 233, language: "JavaScript", name: "dularion/streama", stars: 3911,
  url: "https://github.com/dularion/streama"},
 %GithubTrendEx.Repo{contributors: ["ryanmcdermott", "vsemozhetbyt", "acparas",
   "HemantPawar", "kurtommy"],
  description: "🛁 Clean Code concepts adapted for JavaScript", forks: 566,
  language: "JavaScript", name: "ryanmcdermott/clean-code-javascript",
  stars: 7696, url: "https://github.com/ryanmcdermott/clean-code-javascript"},
 %GithubTrendEx.Repo{contributors: ["rgmorris", "Eli-Zaretskii", "monnier",
   "lektu", "eggert"], description: "Rust ❤️ Emacs", forks: 38,
  language: "Emacs Lisp", name: "Wilfred/remacs", stars: 546,
  url: "https://github.com/Wilfred/remacs"},
...
```

```elixir
iex> GithubTrendEx.trend("elixir", "weekly") |> GithubTrendEx.list
[%GithubTrendEx.Repo{contributors: ["josevalim", "lexmag", "ericmj", "alco",
   "eksperimental"],
  description: "Elixir is a dynamic, functional language designed for building scalable and maintainable applications",
  forks: 1236, language: "Elixir", name: "elixir-lang/elixir", stars: 9043,
  url: "https://github.com/elixir-lang/elixir"},
 %GithubTrendEx.Repo{contributors: ["securingsincity", "slashdotdash"],
  description: "Feature toggle library for elixir", forks: 1,
  language: "Elixir", name: "securingsincity/molasses", stars: 32,
  url: "https://github.com/securingsincity/molasses"},
 %GithubTrendEx.Repo{contributors: ["chrismccord", "josevalim", "scrogson",
   "gjaldon", "darkofabijan"], description: "Productive. Reliable. Fast.",
  forks: 968, language: "Elixir", name: "phoenixframework/phoenix", stars: 8486,
  url: "https://github.com/phoenixframework/phoenix"},
 %GithubTrendEx.Repo{contributors: ["josevalim", "ericmj", "michalmuskala",
   "laurocaetano", "whatyouhide"],
  description: "A database wrapper and language integrated query for Elixir",
  forks: 555, language: "Elixir", name: "elixir-ecto/ecto", stars: 2375,
  url: "https://github.com/elixir-ecto/ecto"},
...
```

# License
MIT
