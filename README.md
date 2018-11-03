NAME
====

Unicode::Time - Display time using Unicode clock characters

SYNOPSIS
========

    use Unicode::Time;
    say now.DateTime.truncated-to <minute>;
    # > 2018-11-03T16:57:00Z
    say unitime now;
    # > 🕔  [CLOCK FACE FIVE OCLOCK]
    say unitime now, round => Unicode::Time::Down;
    # > 🕟  [CLOCK FACE FOUR-THIRTY]

DESCRIPTION
===========

This module allows converting a `DateTime`'s into a Unicode clock character approximately representing the given time. It exports the `unitime` sub by default which takes a `DateTime` and optionally a `Unicode::Time::Round` rounding mode.

### enum Round

```perl6
enum Round <Up Down Closest>;
```

Rounding modes for `unitime`'s `round` parameter.

### sub unitime

```perl6
sub unitime(
    DateTime:D() $dt,
    Round :$round = Round::Closest
) returns Str
```

Return a Unicode clock character that approximately represents the time component of the given DateTime. There is one character for every half-hour of an analogue clock, 24 in total. They start at `U+1F550` (&#x1F550;). The mapping from non-half-hours to half-hours is specified via the `round` parameter which defaults to `Closest`.

CAVEATS
=======

This module should be updated as Unicode inevitably adds codepoints for all the other handle configurations of the clock.

`unitime` operates on minute, not second or millisecond, precision. This means that, when rounding up, 12:00:59 still is 12 o'clock, but 12:01:00 rounds to half past 12.

AUTHOR
======

Tobias Boege

LICENSE
=======

Artistic-2.0

