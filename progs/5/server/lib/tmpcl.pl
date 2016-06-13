use strict;
use warnings;
use Test::TCP;
use Sfera::TCP::Calc::Client;
use Sfera::TCP::Calc::Server;
use Data::Dumper;
use feature "say";


my $server = Sfera::TCP::Calc::Client->set_connect('127.0.0.1', "1234") or die "can't connect";
while (1) {
    my $mod = <>;
    my $msg = <>;
    chomp $mod;
    chomp $msg;
    Sfera::TCP::Calc::Client->do_request($server, $mod, $msg);
}
