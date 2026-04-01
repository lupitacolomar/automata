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

  def determinize(nfa) do
    start_dfa = MapSet.new([nfa.start])#dfa uses sets !
    stat = [start_dfa]
    transitions_dfa = %{}

  end
  #nfa = Automata.nfa()
  #Automata.determinize(nfa)
end
