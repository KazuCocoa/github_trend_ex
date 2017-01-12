defmodule GithubTrendEx do
  @moduledoc """
  GithubTrendEx get trend data from github.
  """

  alias Floki
  alias HTTPoison
  alias GithubTrendEx.Repo

  @scheme "https://"
  @github_domain "github.com"
  @trending_path "/trending"

  @doc """
  Get github trending from github.com
  """
  @spec trend(bitstring, bitstring) :: bitstring
  def trend(lang \\ "", since \\ "daily") do
    trending_url = trending_url(lang, since)

    trending_url
    |> HTTPoison.get!
    |> Map.get(:body)
  end

  @doc """
  Generate URL for trending

  Example

      iex> GithubTrendEx.trending_url
      "https://github.com/trending?since=daily"

      iex> GithubTrendEx.trending_url("elixir")
      "https://github.com/trending/elixir?since=daily"
  """
  @spec trending_url(bitstring, bitstring) :: bitstring
  def trending_url(lang \\ "", since \\ "daily") do
    case lang do
      s when is_bitstring(s) and byte_size(s) > 0->
        @scheme <> @github_domain <> @trending_path <> "/" <> s <> "?since=#{since}"
      _ ->
        @scheme <> @github_domain <> @trending_path <> "?since=#{since}"
    end
  end

  @doc """
  Return Map `%{name: "a name of the trend", url: "a url to github of the trend", description: "description of the trend"}`
  """
  @spec list(bitstring) :: integer | nil
  def list(html) do
    elements = Floki.find(html, "ol.repo-list > li")
    Enum.map(elements, fn(el) ->
      %Repo {
        name: find_name(el),
        description: find_desc(el),
        url: calculate_url(el),
        language: find_language(el),
        stars: find_stars(el),
        forks: find_forks(el)
      }
    end)
  end

  def find_name(el) do
    [{"a", [{"href", "/" <> name}], _}] =
      el
      |> Floki.find("div > h3 > a")

    name
  end

  def find_desc(el) do
    case Floki.find(el, "div.py-1 > p") do
      [{"p", _, nested}] ->
        Enum.map_join(nested, " ", &(get_text_from(&1)))
      [] ->
        # there's no description
        nil
    end
  end

  def calculate_url(el) do
    @scheme <> @github_domain <> "/" <> find_name(el)
  end

  def find_language(el) do
    case Floki.find(el, "div.f6 > span[itemprop=programmingLanguage]") do
      [{"span", _, [content]}] ->
        content |> String.trim()
      [] ->
        # there's no language
        nil
    end
  end

  def find_stars(el) do
    el
    |> Floki.find("div.f6 > a[aria-label=Stargazers]")
    |> Floki.text()
    |> String.trim()
    |> String.replace(",", "")
    |> String.to_integer()
  end

  def find_forks(el) do
    el
    |> Floki.find("div.f6 > a[aria-label=Forks]")
    |> Floki.text()
    |> String.trim()
    |> String.replace(",", "")
    |> String.to_integer()
  end

  def get_text_from({"a", _arrtibutes, text}) do
    text
    |> List.first
    |> String.strip
  end
  def get_text_from({"img", attributes, _text}) do
    attributes
    |> Enum.find(fn {tag, _value} ->
      tag == "title"
    end)
    |> elem(1)
  end
  def get_text_from({"g-emoji", _attributes, [text]}) do
    text
  end
  def get_text_from(text), do: text |> String.strip
end
