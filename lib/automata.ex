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
    start_dfa = MapSet.new([nfa.start])
    pending = [start_dfa]
    discovered_states = [start_dfa]
    transitions_dfa = %{}

    {all_states, all_transitions} = loop(nfa, pending, discovered_states, transitions_dfa)

    accept_dfa =
      Enum.filter(all_states, fn state_set ->
        Enum.any?(nfa.accept, fn acc -> MapSet.member?(state_set, acc) end)
      end)

    %{
      states: all_states,
      alphabet: nfa.alphabet,
      transitions: all_transitions,
      start: start_dfa,
      accept: accept_dfa
    }
  end

  def loop(_nfa, [], discovered_states, transitions_dfa) do
    {discovered_states, transitions_dfa}
  end
  def loop(nfa, [current|rest], discovered_states, transitions_dfa) do
    {new_discovered, new_pending, new_transitions} =
      Enum.reduce(nfa.alphabet, {discovered_states, rest, transitions_dfa}, fn symbol, {disc, pend, trans} ->
        new_state = transition_func(nfa, current, symbol)
        trans = Map.put(trans, {current, symbol}, new_state)
        if not Enum.member?(disc, new_state) do
          {[new_state | disc], [new_state | pend], trans}
        else
          {disc, pend, trans}
        end
      end)

    loop(nfa, new_pending, new_discovered, new_transitions)
  end

  def transition_func(nfa, states, alphabet_symbol) do
    trans_list =
      Enum.map(states, fn x -> Map.get(nfa.transitions, {x, alphabet_symbol}, []) end)

    final_list = List.flatten(trans_list)
    MapSet.new(final_list)

  end

end

#nfa = Automata.nfa()
#dfa = Automata.determinize(nfa)
#IO.inspect(dfa)
