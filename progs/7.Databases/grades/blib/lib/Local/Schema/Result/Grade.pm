use utf8;
package Local::Schema::Result::Grade;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Local::Schema::Result::Grade

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<grade>

=cut

__PACKAGE__->table("grade");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 homework_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 student_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 teacher_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 points

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "homework_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "student_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "teacher_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "points",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 homework

Type: belongs_to

Related object: L<Local::Schema::Result::Homework>

=cut

__PACKAGE__->belongs_to(
  "homework",
  "Local::Schema::Result::Homework",
  { id => "homework_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 student

Type: belongs_to

Related object: L<Local::Schema::Result::Student>

=cut

__PACKAGE__->belongs_to(
  "student",
  "Local::Schema::Result::Student",
  { id => "student_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 teacher

Type: belongs_to

Related object: L<Local::Schema::Result::Teacher>

=cut

__PACKAGE__->belongs_to(
  "teacher",
  "Local::Schema::Result::Teacher",
  { id => "teacher_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-12-08 19:56:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qPysPiIVqeIgQI17ngqokg

use DDP;

sub  better_grades {
    my $self = shift;
    return $self->homework->search_related('grades',
        { 'me.points' => {'>' => $self->points }},
        { order_by => { -desc => "points" }},
    );

}
# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
