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

    trending_url
    |> HTTPoison.get!
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
    names =
      html
      |> Floki.find("ol.repo-list > li > div > h3 > a")

    descriptions =
      html
      |> Floki.find("ol.repo-list > li > .py-1 > p")

    Enum.zip(names, descriptions)
    |> Enum.reduce([], fn  {{"a", href, _}, {"p", _, nested}}, acc ->
      {_tag, link} = List.first href
      desc = Enum.map_join nested, " ", &(get_text_from(&1))

      List.flatten [acc | [%{name: link, url: @scheme <> @github_domain <> link, description: desc}]]
    end)
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
