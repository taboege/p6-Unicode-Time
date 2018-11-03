#!/usr/bin/env perl6

use Test;
use Unicode::Time;

subset RoundMode of Str where 'up'|'down'|'closest';

sub get-round (RoundMode $round-mode --> Unicode::Time::Round) {
    Unicode::Time::Round::{tc $round-mode}
}

sub test-time ($time, *%results) {
    subtest $time => {
        plan 3;
        my $dt = DateTime.new($time);
        for %results.kv -> $round-mode, $expected {
            my $round = get-round $round-mode;
            is unitime($dt, :$round), $expected;
        }
    }
}

plan 4;

subtest "o'clock" => {
    plan 3;
    test-time '2015-12-24T11:59:00Z',
        :up<🕛>, :down<🕦>, :closest<🕛>;
    test-time '2015-12-24T12:00:00Z',
        :up<🕛>, :down<🕛>, :closest<🕛>;
    test-time '2015-12-24T12:01:00Z',
        :up<🕧>, :down<🕛>, :closest<🕛>;
}

subtest "quarter past" => {
    plan 3;
    test-time '2015-12-24T12:14:00Z',
        :up<🕧>, :down<🕛>, :closest<🕛>;
    test-time '2015-12-24T12:15:00Z',
        :up<🕧>, :down<🕛>, :closest<🕧>;
    test-time '2015-12-24T12:16:00Z',
        :up<🕧>, :down<🕛>, :closest<🕧>;
}

subtest "half past" => {
    plan 3;
    test-time '2015-12-24T12:29:00Z',
        :up<🕧>, :down<🕛>, :closest<🕧>;
    test-time '2015-12-24T12:30:00Z',
        :up<🕧>, :down<🕧>, :closest<🕧>;
    test-time '2015-12-24T12:31:00Z',
        :up<🕐>, :down<🕧>, :closest<🕧>;
}

subtest "quarter to" => {
    plan 3;
    test-time '2015-12-24T12:44:00Z',
        :up<🕐>, :down<🕧>, :closest<🕧>;
    test-time '2015-12-24T12:45:00Z',
        :up<🕐>, :down<🕧>, :closest<🕐>;
    test-time '2015-12-24T12:46:00Z',
        :up<🕐>, :down<🕧>, :closest<🕐>;
}
