defmodule Manhattan do

  defstruct(
    current_pos: nil,
    visited: %{},
    current_direction: :right
  )

  @doc """
  distance will take a number and calculate the manhattan distance from a spiralling such as:
  17  16  15  14  13
  18   5   4   3  12
  19   6   1   2  11
  20   7   8   9  10
  21  22  23---> ...

  ## Example
    iex> Manhattan.distance(1)
    0

    iex> Manhattan.distance(12)
    3

    iex> Manhattan.distance(23)
    2

    iex> Manhattan.distance(1024)
    31
  """
  def distance(n) do
    coords()
    |> Enum.at(n - 1)
    |> manhattan()
  end

  def b(threshold \\ 312051) do
    coords()
    |> Stream.transform(%{}, fn coord, acc ->
      sum = sum_neighbours(acc, coord)
      {[sum], Map.put(acc, coord, sum)}
    end)
    |> Stream.filter(&Kernel.>(&1, threshold))
    |> Enum.take(1)
    |> hd()
  end

  defp sum_neighbours(_map, {0, 0}), do: 1
  defp sum_neighbours(map,  {x, y}) do
    [{x+1,y}, {x+1, y+1}, {x, y+1}, {x-1, y+1}, {x-1, y}, {x-1, y-1}, {x, y-1}, {x+1, y-1}]
    |> Stream.map(&Map.get(map, &1, 0))
    |> Enum.sum()
  end

  def coords() do
    Stream.unfold({0,0,:right}, fn acc = {x, y, _dir} -> {{x, y}, next_pos(acc)} end)
  end

  def manhattan({x, y}) do
    abs(x) + abs(y)
  end

  defp next_pos({x, y, :right}) when                       x - 1  === abs(y), do: next_pos({x, y, :up})
  defp next_pos({x, y, :up})    when x >= 0 and y >= 0 and x      === y,      do: next_pos({x, y, :left})
  defp next_pos({x, y, :left})  when x < 0  and y >= 0 and abs(x) === y,      do: next_pos({x, y, :down})
  defp next_pos({x, y, :down})  when x < 0  and y < 0  and x      === y,      do: next_pos({x, y, :right})
  defp next_pos({x, y, :right}), do: {x + 1, y,     :right}
  defp next_pos({x, y, :up}),    do: {x,     y + 1, :up}
  defp next_pos({x, y, :left}),  do: {x - 1, y,     :left}
  defp next_pos({x, y, :down}),  do: {x,     y - 1, :down}

 
end
