package Sfera::TCP::Calc::Client;

use strict;
use warnings;
use IO::Socket;
use Sfera::TCP::Calc;
use feature "say";


sub set_connect {
	my $pkg = shift;
	my $ip = shift;
	my $port = shift;
	use strict;
        use IO::Socket;
        my $socket = IO::Socket::INET->new(
            PeerAddr => $ip,
            PeerPort => $port,
            Proto => "tcp",
            Type => SOCK_STREAM)
            or die "Can`t connect to server!!!";
       return $socket
}

sub do_request {
	my $pkg = shift;
	my $server = shift;
        my $type = shift;
	my $message = shift;
	$server->autoflush(1);
        chomp $type;
	chomp $message;
        my $p_header = Sfera::TCP::Calc->pack_header(length($message));
	my $p_message = Sfera::TCP::Calc->pack_message($message);
        my $num = syswrite $server, $p_header;
        if (!$server->connected()) { close($server);return; }
        syswrite $server, "$type$p_message";
        $p_header = "";
        $p_message = "";
        $num = sysread($server, $p_header, 4);
        if (!$num) { die "end" }
	my $header = Sfera::TCP::Calc->unpack_header($p_header);
        sysread($server, $p_message, $header);
	$message = Sfera::TCP::Calc->unpack_message($p_message);
	warn $message;
	return $message;
}
	#Sfera::TCP::Calc->pack_message
	#Sfera::TCP::Calc->pack_header
	#send to server
	#receive answer
        #Sfera::TCP::Calc->unpack_header
        #Sfera::TCP::Calc->unpack_message(

1;

