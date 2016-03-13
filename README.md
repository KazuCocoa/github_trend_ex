# GithubTrendEx

Get trend repositories from Github.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add current_streak_ex to your list of dependencies in `mix.exs`:

        def deps do
          [{:github_trend_ex, "~> 0.1.1"}]
        end

# How to use

```elixir
iex> GithubTrendEx.trend |> GithubTrendEx.list
[%{description: "A replication of DeepMind's 2016 Nature publication, \"Mastering the game of Go with deep neural networks and tree search,\" details of which can be found on their website.",
   name: "/Rochester-NRT/AlphaGo",
   url: "https://github.com/Rochester-NRT/AlphaGo"},
 %{description: "Turn your two-bit doodles into fine artworks with deep neural networks! An implementation of Semantic Style Transfer.",
   name: "/alexjc/neural-doodle",
   url: "https://github.com/alexjc/neural-doodle"},
 %{description: "Fast multi-core TCP and WebSockets load generator.",
   name: "/machinezone/tcpkali", url: "https://github.com/machinezone/tcpkali"},
 %{description: "The", name: "/FreeCodeCamp/FreeCodeCamp",
   url: "https://github.com/FreeCodeCamp/FreeCodeCamp"},
...
```

```elixir
iex> GithubTrendEx.trend("elixir") |> GithubTrendEx.list
[%{description: "Productive. Reliable. Fast.",
   name: "/phoenixframework/phoenix",
   url: "https://github.com/phoenixframework/phoenix"},
 %{description: "A job processing system that just verks!",
   name: "/edgurgel/verk", url: "https://github.com/edgurgel/verk"},
 %{description: "Elixir is a dynamic, functional language designed for building scalable and maintainable applications",
   name: "/elixir-lang/elixir", url: "https://github.com/elixir-lang/elixir"},
 %{description: "Bringing the power of the command line to chat",
   name: "/operable/cog", url: "https://github.com/operable/cog"},
 %{description: "A static code analysis tool for the Elixir language with a focus on code consistency and teaching.",
...
```

# License
MIT
