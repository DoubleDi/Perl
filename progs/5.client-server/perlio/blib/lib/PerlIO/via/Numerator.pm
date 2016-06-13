package PerlIO::via::Numerator;

use strict;
use Fcntl 'SEEK_CUR';
use feature "say";


sub PUSHED {
	my ($class,$mode) = @_;
	my $obj = {fh => undef, mode => undef, buf => undef, number => 0};
	if($mode eq 'w'){
		$obj->{mode} = '>';
	}
        elsif($mode eq 'r'){
                $obj->{mode} = '<';
        }
        elsif($mode eq 'r+'){
                $obj->{mode} = '+<';
        
	}
	elsif($mode eq 'w+'){
		$obj->{mode} = '+>';
        }
	else {
		die $mode." not supported in PerlIO::via::Numerator";
	}
	return bless $obj,$class;
}

sub OPEN {
	my ($obj,$path,$mode) = @_;
 	open($obj->{fh}, $obj->{mode}, $path) or die "can't open"; 
}

sub FILL {
   	my ($obj) = @_;
    	my $fh = $obj->{fh};
        my $line = <$fh>;
        $line =~ s/\d+?\ (.+)?/$1/;
        $obj->{buf} .= $line;
        return  $line;
}


sub WRITE {
	my ($obj,$buf) = @_;
        my $fh = $obj->{fh};
        $obj->{buf} .= $buf;
        if ($obj->{buf}=~/\n/) {
            FLUSH($obj);
        }
        return length($obj->{buf});
}

sub FLUSH {
	my ($obj) = @_;
	my $fh = $obj->{fh};
 	$obj->{number}++;
        $obj->{buf} = "$obj->{number} ".$obj->{buf};
        print $fh $obj->{buf} or return -1;
        $obj->{buf} = "";
        return 0;
}

1;
