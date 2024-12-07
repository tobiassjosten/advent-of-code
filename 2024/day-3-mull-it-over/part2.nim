import std/rdstdin
import std/strutils

var result: int = 0

var line: string

var first: int = 0
var second: int = 0
var state: int = 0
var enabled: bool = true

while true:
  let ok = readLineFromStdin("", line)
  if not ok: break

  for i, elem in line:
    case elem
    of 'm':
      if enabled:
        first = 0
        second = 0
        state = 1
      else:
        state = 0

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

    of 'd':
      state = -1

    of 'o':
      if state == -1:
        state = -2
      else:
        state = 0

    of 'n':
      if state == -2:
        state = -4
      else:
        state = 0

    of '\'':
      if state == -4:
        state = -5
      else:
        state = 0

    of 't':
      if state == -5:
        state = -6
      else:
        state = 0

    of '(':
      if state == 3:
        state = 4
      elif state == -2:
        state = -3
      elif state == -6:
        state = -7
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
      elif state == -3:
        enabled = true
      elif state == -7:
        enabled = false
      state = 0

    else:
      state = 0

echo result
