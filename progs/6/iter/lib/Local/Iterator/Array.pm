package Local::Iterator::Array;

use strict;
use warnings;

=encoding utf8

=head1 NAME

Local::Iterator::Array - array-based iterator

=head1 SYNOPSIS

    my $iterator = Local::Iterator::Array->new(array => [1, 2, 3]);

=cut

sub new {
    my ($class, %params) = @_;
    return bless \%params, $class;
}

sub next {
   my $class = shift;
   if (@{$class->{'array'}}) {
       return shift $class->{'array'}, 0;
   } else {
       return undef, 1;
   }
   
}

sub all {
   my $class = shift;
   my $arr = $class->{'array'};
   $class->{'array'} = [];
   return $arr;
}

1;
