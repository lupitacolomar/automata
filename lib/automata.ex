defmodule Automata do

  def nfa do
    %{
      :states => [0,1,2,3],
      :alphabet => [:a, :b],
      :transitions => %{
        {0, :a} => [0,1],
        {0, :b} => [0],
        {1, :b} => [2],
        {2, :b} => [3]
      },
      :start => 0,
      :accept => [3]
    }
  end

end
