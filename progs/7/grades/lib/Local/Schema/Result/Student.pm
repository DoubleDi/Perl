use utf8;
package Local::Schema::Result::Student;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Local::Schema::Result::Student

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<student>

=cut

__PACKAGE__->table("student");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 faculty

  data_type: 'varchar'
  is_nullable: 1
  size: 512

=head2 class

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "faculty",
  { data_type => "varchar", is_nullable => 1, size => 512 },
  "class",
  { data_type => "varchar", is_nullable => 1, size => 256 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 grades

Type: has_many

Related object: L<Local::Schema::Result::Grade>

=cut

__PACKAGE__->has_many(
  "grades",
  "Local::Schema::Result::Grade",
  { "foreign.student_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-12-08 19:56:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:w1UoYzaM2P3lHa4wSXpC0g

use DDP;
sub search_overscored_homeworks {
    my $self = shift;
    return $self->grades->search_related('homework',
        { 'homework.max_points' => {'<' => \'me.points' } }
    );
}
# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
