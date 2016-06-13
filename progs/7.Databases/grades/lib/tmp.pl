use strict;
use warnings;
use feature "say";
# use Test::DBIx::Class;
use Local::Schema qw/Schema/;
use DDP;

say "lal";
my $schema = Local::Schema->connect("root", {
      quote_names => 1,
      mysql_enable_utf8 => 1,
  }) or die "asdasdas";

my $rs = $schema->resultset('Homework');
$rs->create({name => 'test1'});
say $rs;
# print join "\n", $rs->all();
$rs->create({name => 'test2', path => '/hw/test2'});
# $rs->create({name => 'test3'});

# my @no_path = $rs->search_no_path()->all();
# say scalar @no_path;
# say $no_path[0]->name;
