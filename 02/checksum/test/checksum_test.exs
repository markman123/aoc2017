defmodule ChecksumTest do
  use ExUnit.Case
  doctest Checksum

  @test_fixture Path.join(__DIR__, "./fixtures/ss.txt")

  def get_test_fixture() do
    @test_fixture |> Checksum.read_spreadsheet()
  end

  test "loads spreadsheet" do
    ss = get_test_fixture()
    assert length(ss) == 3
  end

  test "computes correct answer" do
    ss = get_test_fixture()
    ans = Checksum.checksum(ss)
    assert ans == 18
  end
end
