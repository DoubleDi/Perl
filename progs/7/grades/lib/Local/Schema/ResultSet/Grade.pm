package Local::Schema::ResultSet::Grade;
use utf8;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

sub top_five_grades {
    my $self = shift;
    my $hw = shift;
    my $id = $hw->id;
    my @top_grades = $self->search(
        { homework_id => $id },
        { order_by => { -desc => "points" },
    })->all();
    if (scalar @top_grades > 5) {
        @top_grades = @top_grades[1..5];
    }
    return @top_grades;
}


1;
