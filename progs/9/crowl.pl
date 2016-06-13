use strict;
use warnings;
use feature "say";

use AnyEvent::HTTP;
use Web::Query;
use DDP;
$AnyEvent::HTTP::MAX_PER_HOST = 100;

my $index = 1;
my $results_hash = {};
my $results_array = [];
my $counter;

my $url = <>;
chomp $url;
die "Couldn't get $url" unless defined $url;

my $cv = AE::cv;
$cv->begin;
http_get $url, \&cb;
$results_hash->{$url} = -1;
push @{$results_array}, $url;
$cv->recv;

my $size = 0;
$counter = 10;
foreach my $u (sort { $results_hash->{$b} <=> $results_hash->{$a} } keys %{$results_hash}) {
    $counter--;
    say $u."  =  ".$results_hash->{$u};
    $size += $results_hash->{$u};
    if (!$counter) { last };
}
say $size;

sub cb {
    my $html = shift;
    my $params = shift;
    p $params->{URL};
    my $results;
    if ( scalar @{$results_array} < 10000 ) {
        $results_hash->{$params->{URL}} = length $html;
        my $wq = Web::Query->new_from_html($html);
        $results = $wq->find('a')->map(sub {
            my ($self, $elem_a) = @_;
            my $link_url = $elem_a->attr('href');
            if ($link_url && ($link_url =~ $url) ) {
                if ($link_url =~ /^\/.+\/$/) {
                    $link_url =~ s/^\/(.+\/)$/$1/;
                    $link_url = $url.$link_url
                }
                return $link_url;
            }
        });
    }
    foreach (@{$results}) {
        unless ($_) { next }
        if ( scalar @{$results_array} > 10000 ) { last }
        unless (defined $results_hash->{$_}) {
            $results_hash->{$_} = -1;
            push @{$results_array}, $_;
        }
    }
    $counter = 20;
    # if (scalar @{$results_array} == 1) { $counter = 50 }
    while ($index < scalar @{$results_array}) {
        my $key = $results_array->[$index];
        # p $keysss;
        if ($counter == 0) { last }
        if ($results_hash->{$key} == -1) {
            $results_hash->{$key} = 0;
            $cv->begin;
            $index++;
            http_get $key, \&cb;
            $counter--;
        }
    }
    $cv->end;
}
