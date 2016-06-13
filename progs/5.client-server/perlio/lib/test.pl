use PerlIO::via::Numerator;
use feature "say";

open(my $fhin, "<:via(Numerator)", "input");
open(my $fhout, ">:via(Numerator)", "output");
while (my $a = <$fhin>) {
    say $a;
    print $fhout $a;
}