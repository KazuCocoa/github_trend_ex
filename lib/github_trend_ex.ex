defmodule GithubTrendEx do
  @moduledoc """
  GithubTrendEx get trend data from github.
  """

  alias Floki
  alias HTTPoison

  @scheme "https://"
  @github_domain "github.com"
  @trending_path "/trending"

  @doc """
  Get github trending from github.com
  """
  @spec trend() :: bitstring
  def trend(lang \\ "") do
    trending_url = trending_url lang

    HTTPoison.get!(trending_url)
    |> Map.get(:body)
  end

  @doc """
  Generate URL for trending

  Example

      iex> GithubTrendEx.trending_url
      "https://github.com/trending"

      iex> GithubTrendEx.trending_url("elixir")
      "https://github.com/trending/elixir"
  """
  @spec trending_url(bitstring) :: bitstring
  def trending_url(lang \\ "") do
    case lang do
      s when is_bitstring(s) and byte_size(s) > 0->
        @scheme <> @github_domain <> @trending_path <> "/" <> s
      _ ->
        @scheme <> @github_domain <> @trending_path
    end
  end

  @doc """
  Return Map `%{name: "a name of the trend", url: "a url to github of the trend", description: "description of the trend"}`
  """
  @spec list(bitstring) :: integer | nil
  def list(html) do
    names = Floki.find(html, ".repo-list-name a")
    descriptions = Floki.find(html, "p.repo-list-description")

    Enum.zip(names, descriptions)
    |> Enum.reduce([], fn  {{"a", href, _}, {"p", _, nested}}, acc ->
      {_tag, link} = List.first(href)

      # TODO: Get string from nested tags.
      # e.g. Sometimes trending repository have emoji, url and so on which have a or img tags.
      #  {"p", [{"class", "repo-list-description"}],
      #   ["\n      The ",
      #     {"a", [{"href", "http://FreeCodeCamp.com"}], ["http://FreeCodeCamp.com"]}, <= これを取得したい
      #   " open source codebase and curriculum. Learn to code and help nonprofits.\n    "]},
      desc = Enum.filter(nested, &(is_bitstring(&1)))
             |> List.first
             |> String.strip

      List.flatten [acc | [%{name: link, url: @scheme <> @github_domain <> link, description: desc}]]
    end)
  end
end
