import std/rdstdin
import std/strutils

var result: int = 0

var line: string

var first: int = 0
var second: int = 0
var state: int = 0

while true:
  let ok = readLineFromStdin("", line)
  if not ok: break

  for i, elem in line:
    case elem
    of 'm':
      first = 0
      second = 0
      state = 1

    of 'u':
      if state == 1:
        state = 2
      else:
        state = 0

    of 'l':
      if state == 2:
        state = 3
      else:
        state = 0

    of '(':
      if state == 3:
        state = 4
      else:
        state = 0

    of '0'..'9':
      if state == 4:
        first = first * 10 + parseInt(elem & "")
      elif state == 5:
        second = second * 10 + parseInt(elem & "")
      else:
        state = 0

    of ',':
      if state == 4:
        state = 5
      else:
        state = 0

    of ')':
      if state == 5:
        result += first * second
        echo first, " * ", second, " = ", first * second, " -> ", result
      state = 0

    else:
      state = 0

echo result
