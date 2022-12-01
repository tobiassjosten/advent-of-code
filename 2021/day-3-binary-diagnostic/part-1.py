#!/usr/bin/env python3
import sys

lines = [x.rstrip() for x in sys.stdin]
length = len(lines[0])

gamma, epsilon = 0, 0

for i in range(length):
    numbers = list(map(lambda x: int(x[i]), lines))
    common = (0, 1)[sum(numbers) / len(numbers) > 0.5]

    gamma += pow(2, length-i-1) * common
    epsilon += pow(2, length-i-1) * (1, 0)[common]

print(gamma * epsilon)
