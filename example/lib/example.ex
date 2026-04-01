#every list in a functional prog language is instead, a stack.
defmodule Example do

  def even([], par), do: par #lista vacia devuelve acumulador par
  def even([h|t],par) when rem(h,2)==0, do: even(t, [h|par])
  #checando si h es par pa meterlo en cumulador llamado par.
  def even([h|t], par), do: even(t, par)
  #si h no es par, hay que seguir con tail

  def oddneven([], par, evenlist), do: {par, evenlist}
  def oddneven([h|t], par, evenlist) do
    if rem(h,2) == 0 do
      oddneven(t, [h|par], evenlist)
    else
      oddneven(t,par, [h|evenlist])
    end
  end


  #funciona si llamas reverse([1,2,3], [])
  def reverse([], reversed), do: reversed #devuelve lo que vas acumulando en reversed
  #asi entra al caso baseeee, reverse([], [3,2,1])
  def reverse([h|t], reversed) do
    reverse(t, [h|reversed]) #[h|reversed] is the trick. “pon h al frente de la lista reversed”
  #siempre lo pone al frente, termina quedando al revés.
  #reverse([2,3], [1 | []]). Y [1 | []] es simplemente: [1]
  end


  def searchidx([],idx,cont), do: nil
  def searchidx([h|t], idx, cont) when cont == idx, do: h
  def searchidx([h|t], idx, cont), do: searchidx(t, idx, cont+1)

  def search([], num, idx), do: nil
  def search([h|t], num, idx) when h == num, do: idx
  def search([h|t], num, idx), do: search(t, num, idx+1)


  #function that splits list into 2 parts con length and does merge sort
  #toamdno los primeros c elem de una lista. l es acumulador
  def middle([],c,l), do: l
  def middle([h|t], 0, l), do: l
  def middle([h|t],c,l), do: middle(t, c-1, [h|l])
  #middle([1,2], 5, [])
  def drop([], c), do: []
  def drop(list, 0), do: list
  def drop([h|t], c), do: drop(t, c-1)

  def split(list) do
    mid = div(length(list),2)
    left = middle(list, mid, [])
    right = drop(list,mid)
    {reverse(left), right}
  end

  def merge([], right), do: right
  def merge(left,[]), do: left
  def merge([h1|t1] = left, [h2|t2] = right) do
    if h1 <= h2 do
      [h1| merge(t1,right)]
    else
      [h2| merge(left, t2)]
    end
  end

  def mergesort([]), do: []
  def mergesort([x]), do: [x]
  def mergesort(list) do
    {left, right} = split(list)
    merge(mergesort(left), mergesort(right))# mergue
  end


end
