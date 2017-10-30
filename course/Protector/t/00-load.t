#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 3;

BEGIN {
    use_ok( 'DBHandler' ) || print "Bail out!\n";
    use_ok( 'Parser' ) || print "Bail out!\n";
    use_ok( 'Encryptor' ) || print "Bail out!\n";
}

diag( "Testing DBHandler $DBHandler::VERSION, Perl $], $^X" );
