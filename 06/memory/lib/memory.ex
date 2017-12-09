defmodule Memory do
  @doc """
  Hello world.

  ## Examples

      iex> Memory.redist([0,2,7,0], [], 0, false)
      {4, 5}

  """
  def part_1() do
    get_file()
    |> redist([], 0, false)
  end

  def part_2() do

  end

  def redist(list, hist, iters, _seen_previously = false) do
    last = max_index(list)
    new_list = set_position(list, last, 0)
    |> redistribute(last + 1, Enum.at(list, last))
    
    redist(new_list, [new_list | hist], iters + 1, Enum.member?(hist, new_list) )
  end
  def redist(_, hist = [h|t], iters, _seen_previously) do
    {Enum.find_index(t, &Kernel.===(h, &1)) + 1, iters}
  end

  def max_index(list) do
    Enum.find_index(list, fn i -> i === Enum.max(list) end)
  end


  def set_position(list, position, val) do
    List.replace_at(list, position, val)
  end

  def redistribute(list, _, 0), do: list
 
  def redistribute(list, curr_position, iter_left) do
    {new_list, pos} = _redistribute(list, curr_position)
    redistribute(new_list, pos+1, iter_left - 1)
  end


  def _redistribute(list = [h|t], position) when position > (length(list)-1) do
    {[h+1|t], 0}
  end
  def _redistribute(list, position) do
    new_val = Enum.at(list, position) + 1
    {List.replace_at(list, position, new_val), position}
  end

  def get_file() do
    Path.join(__DIR__, './input.txt')
    |> File.read!
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
