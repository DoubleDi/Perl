use utf8;
package Local::Schema::Result::Teacher;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Local::Schema::Result::Teacher

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<teacher>

=cut

__PACKAGE__->table("teacher");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 last_name

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 floor

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "first_name",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "last_name",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "floor",
  { data_type => "integer", is_nullable => 0 },
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
  { "foreign.teacher_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2015-12-08 19:56:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AsDqBOdO9CZaXCdKttyJWg
sub search_by_name {
    my ($self, $name) = @_;
    return $self->search({
        -or => [
            last_name => {'like', "%$name%"},
            first_name => {'like', "%$name%"},
        ]
    });
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
