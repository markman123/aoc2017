defmodule MemoryTest do
  use ExUnit.Case
  doctest Memory

  test "turns into list" do
    assert Memory.get_file() == [4, 10, 4, 1, 8,4,9,14,5,1,14,15,0,15,3,5]
  end
end
