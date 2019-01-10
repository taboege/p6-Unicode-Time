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

Approximate a C<DateTime>'s time with a Unicode clock character with
the C<unitime> sub, which is exported by default. Unicode clock characters
have half-hour precision (currently?). C<unitime> takes a C<DateTime> and
optionally a C<Unicode::Time::Round> rounding mode.

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
C<round> parameter which defaults to C<Closest>.
»
sub unitime (DateTime:D() $dt, Round :$round? = Closest --> Str) is export {
    my $half-hour = do given $round {
        # Minute with second and millisecond as fraction
        my $minute = $dt.minute + $dt.second / 60;
        when Up      { ceiling $minute / 30 }
        when Down    {   floor $minute / 30 }
        when Closest {   round $minute / 30 }
    }
    my $hour = $dt.hour + $half-hour div 2;
    $half-hour mod= 2;
    $hour = ($hour - 1) mod 12 + 1; # 0100 to 1230
    my $handle = $half-hour == 0 ?? ' OCLOCK' !! '-THIRTY';
    uniparse "CLOCK FACE %ENGLISH{$hour}$handle"
}

=begin pod
=head1 CAVEATS

This module should be updated as Unicode inevitably adds codepoints for
all the other handle configurations of the clock.

=head1 AUTHOR

Tobias Boege

=head1 LICENSE

Artistic-2.0

=end pod
