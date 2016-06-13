package Local::Hackathon::Worker::Fetcher;

use Mouse::Role;
use LWP::Simple;
use DDP;
use 5.018;

has '+source',       default => 'fetch';
has '+destination',  default => 'og';

sub process 
{
    my ($self, $task) = @_;
    $task->{'HTML'} = get $task->{'URL'};
    die "Couldn't get $task->{'URL'}" unless defined $task->{'HTML'};
    say "got HTML";
    return $task;
}
1;
