defmodule Roman do
  def numerals(number, roman) when number >= 1000 do
    numerals(number - 1000, roman <> "M")
  end

  def numerals(number, roman) when number >= 900 do
    numerals(number - 900, roman <> "CM")
  end

  def numerals(number, roman) when number >= 500 do
    numerals(number - 500, roman <> "D")
  end

  def numerals(number, roman) when number >= 400 do
    numerals(number - 400, roman <> "CD")
  end

  def numerals(number, roman) when number >= 100 do
    numerals(number - 100, roman <> "C")
  end

  def numerals(number, roman) when number >= 90 do
    numerals(number - 90, roman <> "XC")
  end

  def numerals(number, roman) when number >= 50 do
    numerals(number - 50, roman <> "L")
  end

  def numerals(number, roman) when number >= 40 do
    numerals(number - 40, roman <> "XL")
  end

  def numerals(number, roman) when number >= 10 do
    numerals(number - 10, roman <> "X")
  end

  def numerals(number, roman) when number == 9 do
    numerals(number - 9, roman <> "IX")
  end

  def numerals(number, roman) when number >= 5 do
    numerals(number - 5, roman <> "V")
  end

  def numerals(number, roman) when number >= 4 do
    numerals(number - 4, roman <> "IV")
  end

  def numerals(number, roman) when number <= 3 do
    roman <> String.duplicate("I", number)
  end

  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    numerals(number, "")
  end
end
