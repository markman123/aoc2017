defmodule Checksum do
  def run(location) do
    location
    |> read_spreadsheet()
    |> checksum()
  end

  def read_spreadsheet(location) do
    location
    |> File.read!
    |> String.split("\n", trim: true)
    |> Enum.map(fn(x) -> String.replace(x, "\r","") end)
    |> Enum.map(fn(x) -> String.split(x) end)
    |> Enum.map(fn(x) -> Enum.map(x, fn(y) -> String.to_integer(y) end) end)
  end

  def checksum(ss) do
    ss
    |> Enum.map(&process_row/1)
    |> Enum.sum()
  end

  def process_row(row) do
    min = Enum.min(row)
    max = Enum.max(row)
    max - min
  end
end
