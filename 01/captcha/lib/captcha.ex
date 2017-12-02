defmodule Captcha do

  defstruct(
    current_sum: 0,
    first_dig: 0,
    prev_dig: 0
  )
  @doc """
  The captcha requires you to review a sequence of digits
  (your puzzle input) and find the sum of all digits that
  match the next digit in the list. The list is circular,
  so the digit after the last digit is the first digit in
  the list.

  ## Examples

      iex> Captcha.captcha(1122)
      3

      iex> Captcha.captcha(1111)
      4

      iex> Captcha.captcha(1234)
      0

      iex> Captcha.captcha(91212129)
      9

  """
  def captcha(digits) do
    digits
    |> to_string()
    |> String.codepoints()
    |> Enum.map(fn x -> x |> String.to_integer end)
    |> IO.inspect
  end

  def process_list(list) do
      
  end

  def process_dig(dig1, dig1) do
    dig1 * 2
  end
  def process_dig(_, _) do
    0
  end
end
