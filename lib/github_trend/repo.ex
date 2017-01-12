defmodule GithubTrendEx.Repo do
  @moduledoc """
  The struct repersenting a Github Repo
  """

  defstruct [
    :name,
    :url,
    :description,
    :language,
    :stars
  ]
end
