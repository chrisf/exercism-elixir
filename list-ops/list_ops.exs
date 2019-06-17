defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list) do
    reduce(list, 0, fn _, acc -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(list) do
    reduce(list, [], &[&1 | &2])
  end

  @spec map(list, (any -> any)) :: list
  def map(list, f) do
    list |> reverse |> reduce([], &[f.(&1) | &2])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, f) do
    list |> reverse |> reduce([], &if(f.(&1), do: [&1 | &2], else: &2))
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc

  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a |> reverse |> reduce(b, &[&1 | &2])
  end

  @spec concat([[any]]) :: [any]
  def concat(list) do
    list |> reverse |> reduce([], &append(&1, &2))
  end
end
