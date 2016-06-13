package Local::Iterator::Concater;

use strict;
use warnings;

use feature "say";
use DDP;

=encoding utf8

=head1 NAME

Local::Iterator::Concater - concater of other iterators

=head1 SYNOPSIS

    my $iterator = Local::Iterator::Concater->new(
        iterators => [
            $another_iterator1,
            $another_iterator2,
        ],
    );

=cut

sub new {
    my ($class, %params) = @_;
    $params{'num'} = 0;
    return bless \%params, $class;
}

sub next {
    my $class = shift;
    my ($elem, $status);
    $status = 1;
    while ($status) {
        if ($class->{'num'} > $#{$class->{'iterators'}}) { return undef, 1 }
        ($elem, $status) = $class->{'iterators'}[$class->{'num'}]->next();
        if ($status) {
            $class->{'num'}++;
        } else {
            last;
        }
    }
    return $elem, 0;
}

sub all {
    my $class = shift;
    my @resdata;
    my ($elem, $status);
    $status = 1;
    while ($class->{'num'} <= $#{$class->{'iterators'}}) {
        ($elem, $status) = $class->{'iterators'}[$class->{'num'}]->next();
        if ($status) {
            $class->{'num'}++;
        } else {
            push @resdata, $elem;
        }
    }
    return \@resdata;
}

1;
