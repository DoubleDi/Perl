package Local::GetterSetter::Test;
use strict;
use warnings;
use DDP;
use 5.018;

use Test::More tests => 4;

use Local::GetterSetter qw(test_name another_test_name);

our $test_name = 2;
our $another_test_name = 'another 2';

say get_test_name();
say get_another_test_name();

set_test_name(42);
set_another_test_name(7);
say $test_name;
say $another_test_name;

# is($test_name, 42, 'set');
# is($another_test_name, 7, 'set another');
