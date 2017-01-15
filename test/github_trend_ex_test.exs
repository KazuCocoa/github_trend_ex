defmodule GithubTrendExTest do
  use ExUnit.Case
  doctest GithubTrendEx

  setup do
    {:ok, [trend: File.read! "test/data/trend_sample.html"]}
  end

  test "trend items", context do
    list = GithubTrendEx.list context[:trend]
    assert Enum.count(list) == 25

    item0 = List.first list
    assert item0.name == "jwasham/google-interview-university"
    assert item0.url == "https://github.com/jwasham/google-interview-university"
    assert item0.description == String.strip ~s"""
    A complete daily plan for studying to become a Google software engineer.
    """

    item2 = Enum.at list, 2
    assert item2.name == "facebookincubator/TextLayoutBuilder"
    assert item2.url == "https://github.com/facebookincubator/TextLayoutBuilder"
    assert item2.description == String.strip ~s"""
    An Android library that allows you to build text layouts more easily.
    """

    item12 = Enum.at list, 12
    assert item12.name == "material-components/material-components-android"
    assert item12.url == "https://github.com/material-components/material-components-android"
    assert item12.description == String.strip ~s"""
    Modular and customizable Material Design UI components for Android
    """
  end

  test "#get_text_from for p tag" do
    a_tag = {"a", [{"href", "http://FreeCodeCamp.com"}], ["http://FreeCodeCamp.com"]}
    assert GithubTrendEx.get_text_from(a_tag) == "http://FreeCodeCamp.com"
  end

  test "#get_text_from for img tag" do
    img_tag = {"img",
               [{"class", "emoji"}, {"title", ":sparkles:"}, {"alt", ":sparkles:"},
                {"src",
                 "https://assets-cdn.github.com/images/icons/emoji/unicode/2728.png"},
                {"height", "20"}, {"width", "20"}, {"align", "absmiddle"}], []}
    assert GithubTrendEx.get_text_from(img_tag) == ":sparkles:"
  end

  test "#get_text_from for g-emoji tag" do
    emoji_tag = {"g-emoji",
                 [{"alias", "postbox"},
                  {"fallback-src", "https://assets-cdn.github.com/images/icons/emoji/unicode/1f4ee.png"},
                  {"ios-version", "6.0"}],
                 ["📮"]}

    assert GithubTrendEx.get_text_from(emoji_tag) == "📮"
  end

  test "#get_text_from for pure text" do
    text = "\n      The "
    assert GithubTrendEx.get_text_from(text) == "The"
  end
end
