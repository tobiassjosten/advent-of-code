#!/usr/bin/env python3
import sys

lines = [x.rstrip() for x in sys.stdin]
length = len(lines[0])

oxygen, co2 = lines, lines

def Common(numbers):
    ints = list(map(lambda x: int(x[i]), numbers))
    return ("0", "1")[sum(ints) / len(ints) >= 0.5]

for i in range(length):
    if len(oxygen) > 1:
        common = Common(oxygen)
        oxygen = [number for number in oxygen if common == number[i]]

    if len(co2) > 1:
        common = Common(co2)
        co2 = [number for number in co2 if Common(co2) != number[i]]

    if len(oxygen) == 1 and len(co2) == 1:
        break

print(int(oxygen[0], 2) * int(co2[0], 2))
