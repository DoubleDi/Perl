use strict;
use warnings;
use Test::TCP;
use Sfera::TCP::Calc::Client;
use Sfera::TCP::Calc::Server;
use Data::Dumper;

Sfera::TCP::Calc::Server->start_server("1234");


