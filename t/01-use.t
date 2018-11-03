#!/usr/bin/env perl6

use Test;
use Unicode::Time;

plan 1;

is unitime(DateTime.new('2015-12-24T12:23:00Z'), round => Unicode::Time::Down), "🕛";
