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

      desc = nested
             |> Enum.reduce("", fn tag, acc ->
               acc <> " " <> get_text_from(tag)
             end)
             |> String.strip

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
    |> Enum.find(fn {tag, value} ->
      tag == "title"
    end)
    |> elem(1)
  end
  def get_text_from(text), do: text |> String.strip
end
