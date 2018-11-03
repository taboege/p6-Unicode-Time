#!/usr/bin/env perl6

use Test;
use Unicode::Time;

sub test-time ($hour, $minute, $expected) {
    my $dt = DateTime.new: sprintf '2015-12-24T%02d:%02d:00Z', $hour, $minute;
    is unitime($dt), $expected;
}

plan 24 × 2;

test-time  0,  0, <🕛>;
test-time  0, 30, <🕧>;
test-time  1,  0, <🕐>;
test-time  1, 30, <🕜>;
test-time  2,  0, <🕑>;
test-time  2, 30, <🕝>;
test-time  3,  0, <🕒>;
test-time  3, 30, <🕞>;
test-time  4,  0, <🕓>;
test-time  4, 30, <🕟>;
test-time  5,  0, <🕔>;
test-time  5, 30, <🕠>;
test-time  6,  0, <🕕>;
test-time  6, 30, <🕡>;
test-time  7,  0, <🕖>;
test-time  7, 30, <🕢>;
test-time  8,  0, <🕗>;
test-time  8, 30, <🕣>;
test-time  9,  0, <🕘>;
test-time  9, 30, <🕤>;
test-time 10,  0, <🕙>;
test-time 10, 30, <🕥>;
test-time 11,  0, <🕚>;
test-time 11, 30, <🕦>;

test-time 12,  0, <🕛>;
test-time 12, 30, <🕧>;
test-time 13,  0, <🕐>;
test-time 13, 30, <🕜>;
test-time 14,  0, <🕑>;
test-time 14, 30, <🕝>;
test-time 15,  0, <🕒>;
test-time 15, 30, <🕞>;
test-time 16,  0, <🕓>;
test-time 16, 30, <🕟>;
test-time 17,  0, <🕔>;
test-time 17, 30, <🕠>;
test-time 18,  0, <🕕>;
test-time 18, 30, <🕡>;
test-time 19,  0, <🕖>;
test-time 19, 30, <🕢>;
test-time 20,  0, <🕗>;
test-time 20, 30, <🕣>;
test-time 21,  0, <🕘>;
test-time 21, 30, <🕤>;
test-time 22,  0, <🕙>;
test-time 22, 30, <🕥>;
test-time 23,  0, <🕚>;
test-time 23, 30, <🕦>;
