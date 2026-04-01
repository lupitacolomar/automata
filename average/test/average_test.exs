defmodule AverageTest do
  use ExUnit.Case
  doctest Average

  test "greets the world" do
    assert Average.hello() == :world
  end
end
