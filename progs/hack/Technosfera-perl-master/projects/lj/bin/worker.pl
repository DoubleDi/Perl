#!/usr/bin/env perl

use strict;
use lib::abs '../lib';
use Getopt::Long;
use DDP;

#BEGIN{GetOptions}
use Local::Hackathon::Worker shift;
my $host = '192.168.0.65';
my $port = '3456';
# p @ARGV;
# GetOptions("host=s" => \$host, "port=i" => \$port) or die;
while() {
    eval {
        p $host;
        p $port;
        my $promoter_client = Local::Hackathon::Client->new(host => $host,port => $port);
        my $worker = Local::Hackathon::Worker->new(client=>$promoter_client);
        $worker->run();
    1} or do { warn "error".$@ };
    sleep 1;
}
