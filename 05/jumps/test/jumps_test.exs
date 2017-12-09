defmodule JumpsTest do
  use ExUnit.Case
  doctest Jumps

  test "opens file aiight" do
    l =  Jumps.open_input() |> Jumps.split_string()
    assert l |> Enum.count() == 1078
    assert Enum.at(l, 0) == 0
  end

  test "calculates correct" do
    assert Jumps.part_1() == 373160
  end
end
