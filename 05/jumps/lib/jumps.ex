defmodule Jumps do
  @moduledoc """
  Documentation for Jumps.
  """

  @doc """
  Jumps example (http://adventofcode.com/2017/day/5)[http://adventofcode.com/2017/day/5]
  
  ## Examples
  
  iex> Jumps.jump([0,3,0,1,-3])
  5

  """
  def part_1() do
    open_input()
    |> split_string()
    |> jump()
  end

  def jump(list_of_instructions) do
    _jump(list_of_instructions, %{n: 0, curr_position: 0})
  end

  def _jump(list_of_instructions, %{n: n, curr_position: curr_position}) when curr_position >= 0 and curr_position <= (length(list_of_instructions) - 1)  do
    
    curr_val = Enum.at(list_of_instructions, curr_position)
    new_position = curr_position + curr_val
    new_list = List.replace_at(list_of_instructions, curr_position, curr_val + 1)
    _jump(new_list, %{n: n + 1, curr_position: new_position})
  end
  def _jump(_, %{n: n}),  do: n

  def split_string(str) do
    str
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> String.replace(s,"\r","") end)
    |> Enum.map(&String.to_integer/1)
  end

  def open_input() do
    Path.join(__DIR__, "./input.txt")
    |> File.read!()
  end
end
