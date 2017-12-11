defmodule Registers do
  def get_file() do
    Path.join(__DIR__, './input.txt')
    |> File.read!()
    |> String.split("\n",trim: true)
    |> Enum.map(fn itm -> String.replace(itm, "\r","") end)
  end
  def part_1() do
    get_file()
    |> max_register()
  end

  def part_2() do
    get_file()
    |> max_ever()
  end
  @doc """
  Max register gets the largest register from a series of instructions

  ## Examples

  iex> Registers.max_register(["b inc 5 if a > 1", "a inc 1 if b < 5", "c dec -10 if a >= 1", "c inc -20 if c == 10"])
  1
  """
  def max_register(list_of_lines) do
    {reg, _ } = list_of_lines
    |> process_lines()

    reg
    |> Map.values()
    |> Enum.max()
  end

  def max_ever(list_of_lines) do
    {_, max_ever} = list_of_lines
    |> process_lines()

    max_ever
  end
  @doc """
  `process_lines` has a list of lines (`list_of_lines`) to be processed, and outputs the map corresponding to the processing of those lines
  ## Examples

  iex> Registers.process_lines(["b inc 5 if a > 1", "a inc 1 if b < 5", "c dec -10 if a >= 1", "c inc -20 if c == 10"] )
  {%{"a" => 1, "c" => -10}, 10}
  """
  def process_lines(list_of_lines) do
    list_of_lines
    |> Enum.map(&parse_line/1)
    |> Enum.reduce({%{},0}, fn(x,{acc, max}) -> update_register(x, {acc, max})  end)
  end
  @doc """

  ## Examples
  Turns a string parse instruction into a map of instructions which can be used by other functions

  iex> Registers.parse_line("b inc 5 if a > 1")
  %{"reg" => "b", "dir" => "inc", "dir_amt" => "5", "check_if" => "a", "check_op" => ">", "check_amt" => "1"}

  iex> Registers.parse_line("aj dec -520 if icd < 9")
  %{"reg" => "aj", "dir" => "dec", "dir_amt" => "-520", "check_if" => "icd", "check_op" => "<", "check_amt" => "9"}
  """
  def parse_line(line) do
    line
    |> String.split(" ")
    |> Enum.with_index()
    |> Enum.map(fn {val, idx} -> { Enum.at(map_dir(), idx), val} end)
    |> Map.new()
    |> Map.drop(["if"])
  end

  def check_predicate(%{"check_if" => reg_to_check, "check_op" => check_op, "check_amt" => check_amt}, register) do
    reg_val = Map.get(register, reg_to_check, 0)
    {val, _} = "#{reg_val} #{check_op} #{check_amt}"
    |> Code.eval_string
    val
  end

  def update_register(line_map, {register, max}) do
    new_register = _update_register(line_map, register, check_predicate(line_map, register))
    {new_register, Enum.max([max | Map.values(new_register)])}
  end

  def _update_register(%{"reg" => reg, "dir" => dir, "dir_amt" => dir_amt}, register, _predicate_val = true) do
    _update_reg(reg, dir, String.to_integer(dir_amt), register)
  end
  def _update_register(_, register, _) do
    register
  end

  def _update_reg(reg, "inc", amt, register) do
    new_val = Map.get(register, reg, 0)
    Map.put(register, reg, new_val + amt)
  end
  def _update_reg(reg, "dec", amt, register) do
    new_val = Map.get(register, reg, 0)
    Map.put(register, reg, new_val - amt)
  end

  def map_dir() do
    ["reg", "dir","dir_amt", "if", "check_if", "check_op", "check_amt"]
  end
end
