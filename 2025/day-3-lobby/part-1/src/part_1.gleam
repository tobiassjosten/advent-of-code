import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string

@external(erlang, "stdin", "getline")
pub fn getline() -> Result(String, Nil)

pub fn main() -> Nil {
  let lines = read_lines([])

  let total =
    lines
    |> list.filter_map(fn(line) { largest_digit(line) |> option_to_result })
    |> list.fold(0, int.add)

  io.println(int.to_string(total))
}

pub fn read_lines(acc: List(String)) -> List(String) {
  case getline() {
    Ok(line) -> read_lines([string.trim(line), ..acc])
    Error(_) -> list.reverse(acc)
  }
}

pub fn option_to_result(opt: Option(a)) -> Result(a, Nil) {
  case opt {
    Some(val) -> Ok(val)
    None -> Error(Nil)
  }
}

pub fn max(a: Int, b: Int) -> Int {
  case a > b {
    True -> a
    False -> b
  }
}

pub fn find_max_digit(graphemes: List(String)) -> Option(Int) {
  case graphemes
    |> list.filter_map(fn(c) { int.parse(c) })
    |> list.reduce(max) {
    Ok(val) -> Some(val)
    Error(_) -> None
  }
}

pub fn pair_to_number(
  pair: #(String, String),
  target: Int,
) -> Result(Int, Nil) {
  let #(first, second) = pair
  case int.parse(first), int.parse(second) {
    Ok(first_digit), Ok(second_digit) ->
      case first_digit == target {
        True -> Ok(first_digit * 10 + second_digit)
        False -> Error(Nil)
      }
    _, _ -> Error(Nil)
  }
}

pub fn drop_last(items: List(a)) -> List(a) {
  items
  |> list.reverse
  |> list.drop(1)
  |> list.reverse
}

pub fn largest_digit(s: String) -> Option(Int) {
  let graphemes = string.to_graphemes(s)

  case graphemes |> drop_last |> find_max_digit {
    None -> None
    Some(largest) -> {
      case pair_with_largest_right_digit(graphemes)
        |> list.filter_map(fn(pair) { pair_to_number(pair, largest) })
        |> list.reduce(max) {
        Ok(val) -> Some(val)
        Error(_) -> None
      }
    }
  }
}

pub fn pair_with_largest_right_digit(
  graphemes: List(String),
) -> List(#(String, String)) {
  case graphemes {
    [] -> []
    [_] -> []
    [first, ..rest] -> {
      case rest
        |> list.filter_map(fn(c) { int.parse(c) })
        |> list.reduce(max) {
        Ok(largest) ->
          [
            #(first, int.to_string(largest)),
            ..pair_with_largest_right_digit(rest)
          ]
        Error(_) -> pair_with_largest_right_digit(rest)
      }
    }
  }
}
