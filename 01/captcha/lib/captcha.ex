defmodule Captcha do

  defstruct(
    current_sum: 0,
    rem_dig: [],
    first_dig: 0,
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
    |> convert_to_list()
    |> process_list(%__MODULE__{}, true)
  end

  def convert_to_list(digits) do
    digits
    |> to_string()
    |> String.codepoints()
    |> Enum.map(fn x -> x |> String.to_integer end)
  end

  def process_list(list = [first_dig | _rest ], state, _is_first_dig = true) do
    new_state = %{state | first_dig: first_dig}
    process_list(list, new_state)
  end

  def process_list([first | []], state) do
    new_sum = state.current_sum + process_dig(first, state.first_dig)
    new_state = %{state | current_sum: new_sum,
                  rem_dig: []
                 }
    process_list([], new_state)
  end
  def process_list([], state), do: state.current_sum
  def process_list(list, state) do
    [ first | rest ] = list
    [ next | _ ] = rest

    new_state = %{state | current_sum: state.current_sum + process_dig(first, next),
              rem_dig: rest
                 }
    process_list(rest, new_state)
  end

  def process_dig(dig1, dig1) do
    dig1
  end
  def process_dig(_, _) do
    0
  end
end
