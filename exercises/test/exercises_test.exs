defmodule ExercisesTest do
  use ExUnit.Case
  doctest Exercises

  test "unique: should work with list of numbers" do
    assert Exercises.unique([2,2,2,1,2,2,5,5,5,5,7,7]) == [2,1,5,7]
    assert Exercises.unique([1,2,2,2,2,2,5,5,5,5,7,7]) == [1,2,5,7]
    assert Exercises.unique([1,2,2,1,2,2,2,5,5,5,5,7,7]) == [1,2,5,7]
  end

  @tag :skip
  test "unique: should work with list of strings" do
    assert Exercises.unique(~w[a a a a b c c a a d e e e e]) == ["a","b","c","d","e"]
  end

  @tag :skip
  test "unique: should work with charlists" do
    assert Exercises.unique('bccaadeeeeaaaa') == 'bcade'
  end

end
