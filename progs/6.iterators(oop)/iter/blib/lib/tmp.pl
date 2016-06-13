use Local::Iterator::Concater;

use feature "say";
use DDP;

my $iterator = Local::Iterator::Concater->new(
    iterators => [
        Local::Iterator::Array->new(array => [1, 2]),
        Local::Iterator::Array->new(array => [3, 4]),
        Local::Iterator::Array->new(array => [5, 6]),
    ],
);

my ($next, $end);

($next, $end) = $iterator->next();
p $next;
p $end;
($next, $end) = $iterator->next();
p $next;
p $end;
($next, $end) = $iterator->next();
p $next;
p $end;
p $iterator->all();
# p $iterator->all();
# ($next, $end) = $iterator->next();
