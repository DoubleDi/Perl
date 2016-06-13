package Local::Schema::ResultSet::Homework;

use utf8;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

sub search_no_path {
    my $self = shift;
    return $self->search({
        path => undef,
    });
}

1;
