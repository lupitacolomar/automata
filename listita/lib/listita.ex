defmodule Listita do
  def sum([]), do: 0
  def sum([h|t]), do: h + sum(t)

  def sum([],acc), do: acc
  def sum([h|t],acc), do: sum(t, acc + h)

  def mult([],acc), do: acc
  def mult([h|t],acc), do: mult(t, acc * h) #operator only changes. aka dif function

  def fold([],acc,_f), do: acc #implementing 3rd parameter, function
  def fold([h|t],acc,f), do: fold(t, f.(h ,acc), f) #calling f

  #if we go. Listita.fold([1,2,3,4,5], 0, &Kernel.+/2) or smt
  #Listita.fold([1,2,3,4,5], 0, fn a, b -> a + b end)
  # Listita.fold([1,2,3,4,5], 0, &(&1 + &2)) anonimos function.
  #Listita.fold([1,2,3,4,5], 1, fn a, b -> IO.puts(a): a * b end)


  def map([], _f), do: []
  def map([h|t], f), do: [f.(h) | map(t,f)]
  #lists.map({1,2,3,4,5}, fn a -> a * 2 end)



  def filter([], _f), do: []
  def filter([h|t], f) do
    case f.(h) do #IF FUNCTION IS TRUE
      true -> [h | filter(t,f)] # THIS ONE
      _ -> filter(t,f) #if not this one lololol
    end
  end

  #lists.filter([1,2,3,4,5], fn a -> rem(a,2)=0 end)

  def length([]), do: 0

  #average of numbers in a list
  def avg([],acc,acc2, _f), do: acc/acc2
  def avg([h|t],acc,acc2, f), do: avg(t, f.(acc,h), acc2 + 1, f) #calling f

  #[sum, length] = lists.fold([34|l], [0,0], fn e, [s,l] -> [s+e, l+1] end)
  #THEN sum / length




  #File.read!("insurance.csv")|> String.split() |> tl |> Enum.map(fn e -> String.split(e, ",") end)
  #File.read!("insurance.csv")|> String.split() |> tl |> Enum.map(fn e -> String.split(e, ",") end) |> Enum.map(fn e -> hd(e) end)
 #File.read!("insurance.csv")|> String.split() |> tl |> Enum.map(fn e -> String.split(e, ",") end) |> Enum.map(fn e -> hd(e) end) |>  Enum.map(fn e -> String.to_interger(e) end) |> Enum.reduce((0,0), fn e, {s, l} -> {s+e, l+1} end )

 #idk
 #or  #File.read!("insurance.csv")|> String.split() |> tl |> Enum.map(fn e -> String.split(e, ",") end) |> Enum.map(fn e -> hd(e) |> String.to_interger() end)
  #

  def avg_age() do
    {sum, len} =
      File.read!("insurance.csv")
      |> String.split()
      |> tl()
      |> Enum.map(fn e -> String.split(e, ",") end)
      |> Enum.map(fn e -> hd(e) end)
      |> Enum.map(fn e -> String.to_integer(e)end)
      |> Enum.reduce({0,0}, fn e , {s, l} -> {s + e, l +1}end)
        sum / len

      end


end
