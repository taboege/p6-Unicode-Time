#minute precision 12:59:59(down) is the same as 11:30:00(down)
#but 12:00:01(up) is also the same as 12:00:00(up)
#12:00:59(up) is different from 12:01:00(up).

#!/usr/bin/env perl6

use Test;
use Unicode::Time;

sub test-time($time1, $time2, $round) {
    my ($dt1, $dt2) = map { DateTime.new("2015-12-24T{$_}Z") }, ($time1, $time2);
    unitime($dt1, :$round) eq unitime($dt2, :$round)
}

plan 3;

 ok test-time("11:59:59", "11:30:00", Unicode::Time::Down);
 ok test-time("12:00:01", "12:00:00", Unicode::Time::Up);
nok test-time("12:00:59", "12:01:00", Unicode::Time::Up);
