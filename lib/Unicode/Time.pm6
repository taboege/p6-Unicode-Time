unit module Unicode::Time;

=begin pod
=head1 NAME

Unicode::Time - Display time using Unicode clock characters

=head1 SYNOPSIS

    use Unicode::Time;
    say now.DateTime.truncated-to <minute>;
    # > 2018-11-03T16:57:00Z
    say unitime now;
    # > 🕔  [CLOCK FACE FIVE OCLOCK]
    say unitime now, round => Unicode::Time::Down;
    # > 🕟  [CLOCK FACE FOUR-THIRTY]

=head1 DESCRIPTION

This module allows converting a C<DateTime>'s into a Unicode clock character
approximately representing the given time. It exports the C<unitime> sub
by default which takes a C<DateTime> and optionally a C<Unicode::Time::Round>
rounding mode.

=end pod

#| Rounding modes for L<unitime>'s C<round> parameter.
our enum Round <Up Down Closest>;

constant %ENGLISH = {
    :1ONE, :2TWO, :3THREE, :4FOUR, :5FIVE, :6SIX,
    :7SEVEN, :8EIGHT, :9NINE, :10TEN, :11ELEVEN, :12TWELVE
} .antipairs.hash;

#|«
Return a Unicode clock character that approximately represents the time
component of the given DateTime. There is one character for every half-hour
of an analogue clock, 24 in total. They start at C<U+1F550> (E<0x1F550>).

The mapping from non-half-hours to half-hours is specified via the
C<:round> parameter which defaults to C<Closest>.
»
sub unitime (DateTime:D() $dt, Round :$round? = Closest --> Str) is export {
    my $minute = do given $round {
        when Up      { ceiling $dt.minute / 30 }
        when Down    {   floor $dt.minute / 30 }
        when Closest {   round $dt.minute / 30 }
    }
    my $hour = $dt.hour + $minute div 2;
    $minute mod= 2;
    $hour = ($hour - 1) mod 12 + 1; # 0100 to 1230
    my $handle = $minute == 0 ?? ' OCLOCK' !! '-THIRTY';
    uniparse "CLOCK FACE %ENGLISH{$hour}$handle"
}

=begin pod
=head1 CAVEATS

This module should be updated as Unicode inevitably adds codepoints for
all the other handle configurations of the clock.

C<unitime> operates on minute, not second or millisecond, precision.
This means that, when rounding up, 12:00:59 still is 12 o'clock, but
12:01:00 rounds to half past 12.

=head1 AUTHOR

Tobias Boege

=head1 LICENSE

Artistic-2.0

=end pod
