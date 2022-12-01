#!/usr/bin/perl -l
use strict;
use warnings;

open(FH, '<', 'input.txt') or die $!;

my $length = 0;
my $depth = 0;

while(<FH>){
    for ($_) {
        if (/^down (\d+)$/) { $depth = $depth + $1; }
        elsif (/^forward (\d+)$/) { $length = $length + $1; }
        elsif (/^up (\d+)$/) { $depth = $depth - $1; }
    }
}

print $length * $depth;

close(FH);
