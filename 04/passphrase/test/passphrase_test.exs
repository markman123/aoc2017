defmodule PassphraseTest do
  use ExUnit.Case
  doctest Passphrase
  

  test "reads the word list" do
    assert Passphrase.word_list()
    |> length() == 513
  end

  test "generates a count" do
    assert Passphrase.generate() == 233
   end

  test "part 2 generates a count" do
    assert Passphrase.part_2() == 233
  end
end
