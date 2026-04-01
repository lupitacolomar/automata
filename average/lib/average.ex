defmodule Average do
  def avg_age() do
    edades =
      File.read!("insurance.csv")
      |> String.split()
      |> tl()
      |> Enum.map(fn e -> String.split(e, ",") end)
      |> Enum.map(fn e -> hd(e) end)
      |> Enum.map(fn e -> String.to_integer(e)end)
      avg(edades, 0, 0, fn a,b -> a + b end)

      end

  def avg([],acc,acc2, _f), do: acc/acc2
  def avg([h|t],acc,acc2, f), do: avg(t, f.(acc,h), acc2 + 1, f) #calling f


end
