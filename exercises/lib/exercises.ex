defmodule Exercises do

  def reverse([], reversed), do: reversed
  def reverse([h|t], reversed) do
    reverse(t, [h|reversed])
  end


  def viendo_si_esta(_elem, []), do: false
  def viendo_si_esta(elem, [h|_t]) when h == elem, do: true
  def viendo_si_esta(elem, [_h|t]), do: viendo_si_esta(elem, t)

  def auxiliar([], acc), do: acc
  def auxiliar([h|t], acc) do
  case viendo_si_esta(h, acc) do
    true -> auxiliar(t, acc)
    false -> auxiliar(t, [h|acc])
    end
  end

  def unique([]), do: []
  def unique([h|t]) do
    r = auxiliar([h|t], [])
    reverse(r, [])
  end
end
