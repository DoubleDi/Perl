package Sfera::TCP::Calc;

use strict;
use warnings;
use feature "say";
my %prio = ( "+" => 4, "-" => 4, "*" => 3, "/" => 3, "(" => -2,  ")" => 5, "**" => 2, "^" => 2, "u-" => 0.5);

sub get_prio {
    my $a = pop @_;
    if (exists($prio{$a})) { return $prio{$a} }
    1;
}

sub TYPE_CALC {
    my $pkg = shift; 
    my $formula = shift;
    my $polska = TYPE_NOTATION($pkg, $formula);
    say $polska;
    $polska =~ s/u\-/-/g;
    my @polska = split(' ', $polska);
    my @stack;
    while (@polska) {
        my $ch = shift @polska;
        if ($ch eq "^") { $ch = "**" } 
        if (get_prio($ch) == 1) { push(@stack, $ch) }
        else {
            my $num1 = pop(@stack);
            my $num2 = pop(@stack);
            push (@stack, eval("$num2 $ch $num1"));
        }
    }
    return pop @stack;
}

sub TYPE_NOTATION     {
    my $pkg = shift; 
    my @formula;
    my $polska = "";
    my @stack;
    my $ch;
    my $form = shift;
    $form =~ s/\*\*/\^/g;
    $form =~ s/(\d+|\D)/ $1 /g;
    $form =~ s/((\d+)\s+)?(\.)\s+(\d+)/$2$3$4/g;
    $form =~ s/(\d+)\s+([eE])\s+([-+]?)\s+(\d+)/$1$2$3$4/g;
    @formula = split(' ', $form);
    while (@formula) {
        $ch = shift @formula;
        if ($ch eq "-" && (!@stack || get_prio($stack[-1]) != 1)) { $ch = "u-" }
        while (@stack && get_prio($stack[-1]) <= get_prio($ch)) {
            if ($stack[-1] eq "(" && $ch ne ")") { last }
            my $tmp = pop(@stack);
            if ($tmp ne "(") { 
                if ($polska) { $polska.= " "; }
                $polska = $polska.$tmp; 
            }
            else { last }
        }
        if ($ch ne ")") { push(@stack, $ch) }
    }
    while (@stack) { 
        my $tmp = pop(@stack);
        $polska = $polska."$tmp ";
    }
    return $polska
}
sub TYPE_BRACKETCHECK {
    my $pkg = shift; 
    my $formula = shift;
    my @formula = split('', $formula);
    my @stack;
    for (@formula) {
        if ($_ eq "{" || $_ eq "(" || $_ eq "[") { push @stack, $_ }
        elsif ($_ eq "}" || $_ eq ")" || $_ eq "]") {
            if (!@stack) { return 0 }
            my $symb = pop @stack;
            if ($_ eq "}" && $symb ne "{") { return 0 } 
            if ($_ eq ")" && $symb ne "(") { return 0 } 
            if ($_ eq "]" && $symb ne "[") { return 0 } 
        }
    }
    if (@stack) { return 0 }
    return 1;
}

sub pack_header {
	my $pkg = shift;
	my $size = shift;
        $size = pack "V", $size;
	return $size;
}

sub unpack_header {
	my $pkg = shift;
	my $header = shift;
        $header = unpack "V", $header;
        return $header;
}

sub pack_message {
	my $pkg = shift;
	my $message = shift;
        $message = pack "a*", $message;
	return $message;
}

sub unpack_message {
	my $pkg = shift;
	my $message = shift;
        $message = unpack "a*", $message;
        return $message;
}

1;
