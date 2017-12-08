defmodule Passphrase do

  def word_list() do

    Path.join(__DIR__, "./input.txt")
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
  end

  def generate() do
    word_list()
    |> Stream.reject(&Enum.empty?/1)
    |> Stream.map(&Enum.sort/1)
    |> Stream.filter(&Kernel.===(Enum.uniq(&1), &1))
    |> IO.inspect()
    |> Enum.count()
  end

  def part_2() do
    word_list()
    |> Stream.reject(&Enum.empty?/1)
    |> Stream.map(fn phrase -> Enum.map(phrase, &String.graphemes/1) end)
    |> Stream.map(fn phrase -> Enum.map(phrase, &Enum.sort/1) end)
    |> Stream.filter(&Kernel.===(Enum.uniq(&1), &1))
    |> Enum.count()
  end

end
