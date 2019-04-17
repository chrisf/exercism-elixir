defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    words = sentence
    |> String.downcase
    |> String.replace(~r/@|#|\$|%|&|\^|:|_|!|,/u, " ")
    |> String.split
    Enum.reduce(words, Map.new, &count/2)
  end

  defp count(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end
