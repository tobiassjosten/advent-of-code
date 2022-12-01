<?php

$map = [];

$overlaps = 0;

while ($line = trim(fgets(STDIN))) {
    if (!preg_match('~^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$~', $line, $match)) {
        exit("invalid line: '$line'\n");
    }

    if ($match[1] !== $match[3] && $match[2] !== $match[4]) {
        continue;
    }

    for ($x = min($match[1], $match[3]); $x <= max($match[3], $match[1]); $x++) {
        for ($y = min($match[2], $match[4]); $y <= max($match[4], $match[2]); $y++) {
            if (!isset($map[$x][$y])) {
                $map[$x][$y] = 0;
            }
            $overlaps += $map[$x][$y] == 1 ? 1 : 0;
            $map[$x][$y]++;
        }
    }
}

echo "$overlaps\n";
