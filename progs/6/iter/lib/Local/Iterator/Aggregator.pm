package Local::Iterator::Aggregator;

use strict;
use warnings;
use DDP;
use feature "say";

=encoding utf8

=head1 NAME

Local::Iterator::Aggregator - aggregator of iterator

=head1 SYNOPSIS

    my $iterator = Local::Iterator::Aggregator->new(
        chunk_length => 2,
        iterator => $another_iterator,
    );

=cut

sub new {
    my ($class, %params) = @_;
    return bless \%params, $class;
}

sub next {
    my $class = shift;
    my $iter = $class->{'chunk_length'};
    my @data;
    my $end = 0;
    while ($iter--) {
        if ($class->{'iterator'}) {
            my ($elem, $status) = $class->{'iterator'}->next();
            if ($status) { $end = 1;last };
            push @data, $elem; 
        }
    }
    if (@data) {
        return \@data, $end;
    } else {
        return undef, 1;
    }
}

sub all {
    my $class = shift;
    my @resdata;
    my $end = 0;
    while (!$end) {
        my $iter = $class->{'chunk_length'};
        my @data;
        while ($iter--) {
            if ($class->{'iterator'}) {
                my ($elem, $status) = $class->{'iterator'}->next();
                if ($status) { $end = 1; last };
                push @data, $elem; 
            }
        }
        push @resdata, \@data;
    }
    return \@resdata;
}

1;
