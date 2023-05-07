defmodule Limelix.QoSRatesTest do
  use ExUnit.Case
  @moduletag :limelix
  doctest Limelix.QoSRates

  alias Limelix.QoSRates

  describe "next_rate/3" do
    test "down rate" do
      state = QoSRates.next_rate([:too_many_requests], 100, {nil, {1, 0}})
      assert {200, {2, 0}} == state 

      state = QoSRates.next_rate([:too_many_requests], 100, state)
      assert {300, {3, 0}} == state

      state = QoSRates.next_rate([:too_many_requests], 100, state)
      assert {400, {4, 0}} == state

      {_, {tilt, _}} = state
      state = QoSRates.next_rate([:too_many_requests], 100, {nil, {tilt, 1}})
      assert {400, {4, 0}} == state
    end

    test "up rate" do
      state = QoSRates.next_rate([:ok], 100, {400, {1, 0}})
      assert {100, {1, 0}} == state 

      state = QoSRates.next_rate([:ok], 100, {400, {2, 0}})
      assert {399, {2, 1}} == state 

      state = QoSRates.next_rate([:ok], 100, state)
      assert {398, {2, 2}} == state 

      state = QoSRates.next_rate([:ok], 100, state)
      assert {396, {2, 3}} == state 

      state = QoSRates.next_rate([:ok], 100, state)
      assert {393, {2, 4}} == state 

      state = QoSRates.next_rate([:ok], 100, state)
      assert {388, {2, 5}} == state 

      state = QoSRates.next_rate([:ok], 500, state)
      assert {500, {1, 6}} == state 
    end
  end
end
