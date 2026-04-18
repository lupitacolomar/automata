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

  def e_closure(nfa, states) do
    initial = MapSet.new(states)
    e_closure_loop(nfa, MapSet.to_list(initial), initial)
  end

  defp e_closure_loop(_nfa, [], visited) do
    visited
  end
  defp e_closure_loop(nfa, [current | rest], visited) do
    epsilon_neighbors = Map.get(nfa.transitions, {current, :eps}, [])
    new_states = Enum.filter(epsilon_neighbors, fn s ->
      not MapSet.member?(visited, s)
    end)

    new_visited = Enum.reduce(new_states, visited, fn s, acc ->
      MapSet.put(acc, s)
    end)

    e_closure_loop(nfa, rest ++ new_states, new_visited)
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

  def nfa_epsilon do
    %{
      states: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      alphabet: [:a, :b],
      transitions: %{
        # epsilon transitions
        {0, :eps} => [1, 7],
        {1, :eps} => [2, 3],
        {4, :eps} => [6],
        {5, :eps} => [6],
        {6, :eps} => [7],
        # transiciones normales
        {2, :a}   => [4],
        {3, :b}   => [5],
        {7, :a}   => [8],
        {8, :b}   => [9],
        {9, :b}   => [10]
      },
      start: 0,
      accept: [10]
    }
  end

  def e_determinize(nfa) do

    start_dfa = e_closure(nfa, [nfa.start])
    pending = [start_dfa]
    discovered_states = [start_dfa]
    transitions_dfa = %{}

    {all_states, all_transitions} = e_det_loop(nfa, pending, discovered_states, transitions_dfa)


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


  def e_det_loop(_nfa, [], discovered_states, transitions_dfa) do
    {discovered_states, transitions_dfa}
  end


  def e_det_loop(nfa, [current | rest], discovered_states, transitions_dfa) do
    {new_discovered, new_pending, new_transitions} =
      Enum.reduce(nfa.alphabet, {discovered_states, rest, transitions_dfa}, fn symbol, {disc, pend, trans} ->

        raw_next = Enum.flat_map(current, fn state ->
          Map.get(nfa.transitions, {state, symbol}, [])
        end)

        new_state = e_closure(nfa, raw_next)


        if MapSet.size(new_state) > 0 do
          trans = Map.put(trans, {current, symbol}, new_state)
          if not Enum.member?(disc, new_state) do
            {[new_state | disc], [new_state | pend], trans}
          else
            {disc, pend, trans}
          end
        else
          {disc, pend, trans}
        end
      end)

    e_det_loop(nfa, new_pending, new_discovered, new_transitions)
  end

end

#nfa = Automata.nfa()
#dfa = Automata.determinize(nfa)
#IO.inspect(dfa)
