use strict;
use 5.018;
use DDP;

my @formula;
my @polska;
my @stack;
my %prio = ( "+" => 4, "-" => 4, "*" => 3, "/" => 3, "(" => -2,  ")" => 5, "**" => 2, "^" => 2, "u-" => 0.5);
my $ch;

sub get_prio {
    my $a = pop @_;
    if (exists($prio{$a})) { return $prio{$a} }
    1;
}



my $form = <>;
$form =~ s/\*\*/\^/g;
$form =~ s/(\d+|\D)/ $1 /g;
$form =~ s/((\d+)\s+)?(\.)\s+(\d+)/$2$3$4/g;
$form =~ s/(\d+)\s+([eE])\s+([-+]?)\s+(\d+)/$1$2$3$4/g;
# say $form;
@formula = split(' ', $form);
while (@formula) {
    $ch = shift @formula;
#      p @formula;
    if ($ch eq "^") { $ch = "**" }
    if ($ch eq "-" && (!@stack || get_prio($stack[-1]) != 1)) { $ch = "u-" }
    while (@stack && get_prio($stack[-1]) <= get_prio($ch)) {
        if ($stack[-1] eq "(" && $ch ne ")") { last }
        my $tmp = pop(@stack);
        if ($tmp ne "(") {push(@polska, $tmp);}
        else { last }
    }
    if ($ch ne ")") { push(@stack, $ch) }
}
while (@stack) {
    my $tmp = pop(@stack);
    push(@polska, $tmp);
}
while (@polska) {
#     p @polska;
    $ch = shift @polska;
    if (get_prio($ch) == 1) { push(@stack, $ch) }
    elsif ($ch eq "u-"){ $polska[0] *= -1; }
    else {
        my $num1 = pop(@stack);
        my $num2 = pop(@stack);
        push (@stack, eval("($num2) $ch ($num1)"));
    }
}
say pop @stack;
