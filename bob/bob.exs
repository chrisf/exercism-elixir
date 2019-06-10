defmodule Bob do
  def hey(input) do
    cond do
      silence?(input)           -> "Fine. Be that way!"
      shouting_question?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input)          -> "Whoa, chill out!"
      question?(input)          -> "Sure."
      true                      -> "Whatever."
    end
  end

  def silence?(input) do
    String.trim(input) == ""
  end

  def question?(input) do
    String.last(input) == "?"
  end

  def has_uppercase?(input) do
    Regex.match?(~r/\p{Lu}/, input)
  end

  def shouting?(input) do
    has_uppercase?(input) && String.upcase(input) == input
  end

  def shouting_question?(input) do
    shouting?(input) && question?(input)
  end
end
