defmodule GithubTrendExTest do
  use ExUnit.Case
  doctest GithubTrendEx

  setup do
    {:ok, [trend: File.read! "test/data/trend_sample"]}
  end

  test "the truth", context do
    list = GithubTrendEx.list context[:trend]
    item = List.first list

    assert Enum.count(list) == 25
    assert item.name == "/Rochester-NRT/AlphaGo"
    assert item.url == "https://github.com/Rochester-NRT/AlphaGo"
    assert item.description == String.strip ~s"""
    A replication of DeepMind's 2016 Nature publication, "Mastering the game of Go with deep neural networks and tree search," details of which can be found on their website.
    """
  end
end
