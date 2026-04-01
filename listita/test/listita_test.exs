defmodule ListitaTest do
  use ExUnit.Case
  doctest Listita

  test "greets the world" do
    assert Listita.hello() == :world
  end
end
