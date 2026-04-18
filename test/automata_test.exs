defmodule AutomataTest do
  use ExUnit.Case

  test "NFA structure" do
    nfa = Automata.nfa()

    assert nfa.states == [0, 1, 2, 3]
    assert nfa.alphabet == [:a, :b]
    assert nfa.start == 0
    assert nfa.accept == [3]
  end

  test "DFA start state" do
    nfa = Automata.nfa()
    dfa = Automata.determinize(nfa)
    assert dfa.start == MapSet.new([0])
  end

  test "DFA accepts" do
    nfa = Automata.nfa()
    dfa = Automata.determinize(nfa)
    assert Enum.any?(dfa.accept, fn s -> MapSet.member?(s, 3) end)
  end

  test "transitions" do
    nfa = Automata.nfa()
    dfa = Automata.determinize(nfa)

    assert Map.get(dfa.transitions, {MapSet.new([0]), :a}) == MapSet.new([0, 1])
    assert Map.get(dfa.transitions, {MapSet.new([0]), :b}) == MapSet.new([0])

    assert Map.get(dfa.transitions, {MapSet.new([0, 1]), :b}) == MapSet.new([0, 2])
  end

  test "e_determinize start" do
    nfa = Automata.nfa_epsilon()
    dfa = Automata.e_determinize(nfa)

    assert dfa.start == MapSet.new([0, 1, 2, 3, 7])
  end

  test "e_determinize tiene estados de aceptacion" do
    nfa = Automata.nfa_epsilon()
    dfa = Automata.e_determinize(nfa)

    assert Enum.any?(dfa.accept, fn s -> MapSet.member?(s, 10) end)
  end

end
