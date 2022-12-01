<?php

$map = [];

$overlaps = 0;

while ($line = trim(fgets(STDIN))) {
    if (!preg_match('~^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$~', $line, $match)) {
        exit("invalid line: '$line'\n");
    }

    [$x, $y] = [$match[1], $match[2]];
    [$xb, $yb] = [$match[3], $match[4]];

    $xp = $x > $xb ? -1 : ($x < $xb ? 1 : 0);
    $yp = $y > $yb ? -1 : ($y < $yb ? 1 : 0);

    while ($x != $xb + $xp || $y != $yb + $yp) {
        if (!isset($map[$x][$y])) {
            $map[$x][$y] = 0;
        }
        $overlaps += $map[$x][$y] == 1 ? 1 : 0;
        $map[$x][$y]++;

        $x += $xp;
        $y += $yp;
    }
}

echo "$overlaps\n";
