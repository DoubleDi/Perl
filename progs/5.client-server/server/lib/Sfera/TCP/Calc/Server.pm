package Sfera::TCP::Calc::Server;

use strict;
use POSIX ":sys_wait_h";
use warnings;
use IO::Socket;
use Sfera::TCP::Calc;
use feature "say";

my $limit = 0;
my $accepted = 0;
my $commands = 0;
my $flag = 1;
sub start_server {
        $SIG{INT} = sub { 
            $flag = 0 
        };

        $SIG{USR1} = sub { 
            say "statics:";
            say "limit: $limit";
            say "accepted: $accepted";
            say "commands: $commands";
        };
	my $pkg = shift;
	my $port = shift;
        my $server = IO::Socket::INET->new(
            LocalPort => $port,
            Type => SOCK_STREAM,
            ReuseAddr => 1,
            Listen => 10)
        or die "Can't create server on port $port: $@ $/";
        while (my $client = $server->accept()) {
            if ($limit >= 5) {
                say "Only 5 clients pls";
                close($client);
                next;
            } else {
                $limit++;
            }
            if (!$flag) { 
                $limit--;
                close($client);
                last; 
            }
            $accepted++;
            my $child = fork();
            if ($child) {  
                close ($client); next;
            }
            if(defined $child){
                close($server);
                $client->autoflush(1);
                while(1) {
                    my $p_header;
                    my $p_message;
                    my $p_type;
                    if (sysread($client, $p_header, 4)) {
                        my $header = Sfera::TCP::Calc->unpack_header($p_header);
                        sysread($client, $p_type, 1);
                        sysread($client, $p_message, $header);
                        my $message = Sfera::TCP::Calc->unpack_message($p_message);
                        say $p_type;
                        say $message;
                        if ($p_type eq "3") {
                            $message = Sfera::TCP::Calc->TYPE_NOTATION($message); 
                        } elsif ($p_type eq "2") {
                            $message = Sfera::TCP::Calc->TYPE_BRACKETCHECK($message); 
                        } elsif ($p_type eq "1") {
                            $message = Sfera::TCP::Calc->TYPE_CALC($message); 
                        } else {
                            $message = "Unknown type";
                        }
                        $p_header = Sfera::TCP::Calc->pack_header(length($message));
                        warn $message;
                        $p_message = Sfera::TCP::Calc->pack_message($message);
                        syswrite $client, $p_header;
                        say "$p_message";
                        syswrite $client, "$p_message";
                    } else {
                        $limit--;
                        close($client);
                        exit;
                    }
                }
            } else { die "Can't fork: $!"; }
        }
        while ($limit) {
            if (waitpid(-1, WNOHANG) > 0) {
                $limit--;
            }
        }
        close( $server )
}
	#init server
	#accept connection
	#fork
	#receive 
	#Sfera::TCP::Calc->unpack_header(...)
	#Sfera::TCP::Calc->unpack_message(...)
	#process
	#Sfera::TCP::Calc->pack_header(...)
	#Sfera::TCP::Calc->pack_message(...)
	#response

1;