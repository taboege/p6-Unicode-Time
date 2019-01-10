use Test;
use Unicode::Time;

sub test-time($time1, $time2, $round) {
    my ($dt1, $dt2) = map { DateTime.new("2015-12-24T{$_}Z") }, ($time1, $time2);
    unitime($dt1, :$round) eq unitime($dt2, :$round)
}

plan 8;

 ok test-time("11:59:59", "11:30:00", Unicode::Time::Down);
nok test-time("12:00:01", "12:00:00", Unicode::Time::Up);
 ok test-time("12:00:59", "12:01:00", Unicode::Time::Up);
nok test-time("12:00:00.001", "12:00:00", Unicode::Time::Up);
 ok test-time("11:59:59.999", "11:30:00", Unicode::Time::Down);
nok test-time("11:29:59.999", "11:59:59.999", Unicode::Time::Closest);
 ok test-time("11:29:59.999", "11:44:59.999", Unicode::Time::Closest);
nok test-time("11:29:59.999", "11:45:00", Unicode::Time::Closest);
