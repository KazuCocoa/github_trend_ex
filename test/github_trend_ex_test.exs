defmodule GithubTrendExTest do
  use ExUnit.Case
  doctest GithubTrendEx

  setup do
    {:ok, [trend: File.read! "test/data/trend_sample"]}
  end

  test "trend items", context do
    list = GithubTrendEx.list context[:trend]
    assert Enum.count(list) == 24

    item0 = List.first list
    assert item0.name == "/Rochester-NRT/AlphaGo"
    assert item0.url == "https://github.com/Rochester-NRT/AlphaGo"
    assert item0.description == String.strip ~s"""
    A replication of DeepMind's 2016 Nature publication, "Mastering the game of Go with deep neural networks and tree search," details of which can be found on their website.
    """

    item2 = Enum.at list, 2
    assert item2.name == "/ryanoasis/nerd-fonts"
    assert item2.url == "https://github.com/ryanoasis/nerd-fonts"
    assert item2.description == String.strip ~s"""
    :abcd: Collection of over 20 patched fonts (over 2,000 variations) & FontForge font patcher python script for Powerline, Font Awesome, Octicons, Devicons, and Vim Devicons. Includes: Droid Sans, Meslo, Source Code, AnonymousPro, Hack, ProFont, Inconsolata, and many more
    """

    item12 = Enum.at list, 12
    assert item12.name == "/MoOx/statinamic"
    assert item12.url == "https://github.com/MoOx/statinamic"
    assert item12.description == String.strip ~s"""
    :scream: Modern static website generator to create dynamic websites using React components :sparkles:
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

  test "#get_text_from for pure text" do
    text = "\n      The "
    assert GithubTrendEx.get_text_from(text) == "The"
  end
end
