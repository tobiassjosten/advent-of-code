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

pub fn digits_to_number(digits: List(Int)) -> Option(Int) {
  case digits {
    [] -> None
    _ -> Some(list.fold(digits, 0, fn(acc, digit) { acc * 10 + digit }))
  }
}

pub fn largest_digit(s: String) -> Option(Int) {
  let graphemes = string.to_graphemes(s)
  let selected_digits = select_digits(graphemes, 11, [])
  digits_to_number(selected_digits)
}

pub fn select_digits(graphemes: List(String), required_right: Int, acc: List(Int)) -> List(Int) {
  case required_right < 0 {
    True -> list.reverse(acc)
    False -> {
      case find_biggest_with_min_right(graphemes, required_right) {
        None -> list.reverse(acc)
        Some(#(digit, position)) -> {
          let remaining = list.drop(graphemes, position + 1)
          select_digits(remaining, required_right - 1, [digit, ..acc])
        }
      }
    }
  }
}

pub fn find_biggest_with_min_right(graphemes: List(String), min_right: Int) -> Option(#(Int, Int)) {
  let max_position = list.length(graphemes) - min_right - 1

  case max_position < 0 {
    True -> None
    False -> {
      let candidates =
        list.index_map(graphemes, fn(g, i) { #(g, i) })
        |> list.filter(fn(pair) { pair.1 <= max_position })
        |> list.filter_map(fn(pair) {
          let #(char, pos) = pair
          case int.parse(char) {
            Ok(digit) -> Ok(#(digit, pos))
            Error(_) -> Error(Nil)
          }
        })

      case candidates {
        [] -> None
        [first, ..rest] ->
          Some(list.fold(rest, first, fn(best: #(Int, Int), current: #(Int, Int)) {
            let #(best_digit, _best_pos) = best
            let #(current_digit, _current_pos) = current
            case current_digit > best_digit {
              True -> current
              False -> best
            }
          }))
      }
    }
  }
}
