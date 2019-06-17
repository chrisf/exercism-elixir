defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count('', _), do: 0

  def count(strand, nucleotide) do
    nucleotide = [nucleotide] |> to_string

    strand
    |> to_string
    |> String.split("", trim: true)
    |> Enum.reduce(0, fn el, acc -> if el == nucleotide, do: acc + 1, else: acc end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map

  def histogram(strand) do
    nucleotides = [?A, ?G, ?C, ?T]
    nucleotides |> Enum.reduce(%{}, &Map.put(&2, &1, count(strand, &1)))
  end
end
