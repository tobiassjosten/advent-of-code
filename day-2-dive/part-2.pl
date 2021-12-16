#!/usr/bin/perl -l
use strict;
use warnings;

open(FH, '<', 'input.txt') or die $!;

my $aim = 0;
my $length = 0;
my $depth = 0;

while(<FH>){
    for ($_) {
        if (/^down (\d+)$/) { $aim = $aim + $1; }
        elsif (/^forward (\d+)$/) { $length = $length + $1; $depth = $depth + $aim * $1; }
        elsif (/^up (\d+)$/) { $aim = $aim - $1; }
    }
}

print $length * $depth;

close(FH);
