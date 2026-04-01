defmodule Automata do

  def nfa do
    %{
      :states => [0,1,2,3],
      :alphabet => [:a, :b],
      :transitions => %{
        {0, :a} => [0,1], #key es estado + symbol -> resultado
        {0, :b} => [0],
        {1, :b} => [2],
        {2, :b} => [3]
      },
      :start => 0,
      :accept => [3]
    }
  end

  def determinize(nfa) do
    start_dfa = MapSet.new([nfa.start])#dfa uses sets ! stays the same as b4
    start = [start_dfa]
    transitions_dfa = %{}

  end
  #nfa = Automata.nfa()
  #Automata.determinize(nfa)

  def transition_func(nfa, states, alphabet_symbol) do
    trans_list =
      Enum.map(states, fn x -> Map.get(nfa.transitions, {x, alphabet_symbol}, []) end) #para recorrer cada estado

    final_list = List.flatten(power_Q) #lista bomnita
    power_Q = MapSet.new(final_list) # dfa

  end

end
