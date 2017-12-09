defmodule Jumps do
  @moduledoc """
  Documentation for Jumps.
  """

  @doc """
  Jumps example (http://adventofcode.com/2017/day/5)[http://adventofcode.com/2017/day/5]
  
  ## Examples
  
  iex> Jumps.jump([0,3,0,1,-3], fn curr_val -> curr_val + 1 end)
  5

  iex> Jumps.jump([0,3,0,1,-3], &Jumps.calc_new_val/1)
  10

  """
  def part_1() do
    open_input()
    |> split_string()
    |> jump(fn curr_val -> curr_val + 1 end)
  end

  def part_2() do
    open_input()
    |> split_string()
    |> jump(&calc_new_val/1)
  end

  def jump(list_of_instructions, fun) do
    _jump(list_of_instructions, %{n: 0, curr_position: 0}, fun)
  end

  def _jump(list_of_instructions, %{n: n, curr_position: curr_position}, fun) when curr_position >= 0 and curr_position <= (length(list_of_instructions) - 1)  do
    
    curr_val = Enum.at(list_of_instructions, curr_position)

    new_position = curr_position + curr_val
    new_val = fun.(curr_val)
    new_list = List.replace_at(list_of_instructions, curr_position, new_val)
    _jump(new_list, %{n: n + 1, curr_position: new_position}, fun)
  end
  def _jump(_, %{n: n}, _),  do: n

  def calc_new_val(curr_val) when curr_val >= 3, do: curr_val - 1
  def calc_new_val(curr_val),                    do: curr_val + 1
  

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
