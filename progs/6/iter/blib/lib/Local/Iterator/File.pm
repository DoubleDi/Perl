package Local::Iterator::File;

use strict;
use warnings;

=encoding utf8

=head1 NAME

Local::Iterator::File - file-based iterator

=head1 SYNOPSIS

    my $iterator1 = Local::Iterator::File->new(file => '/tmp/file');

    open(my $fh, '<', '/tmp/file2');
    my $iterator2 = Local::Iterator::File->new(fh => $fh);

=cut

sub new {
    my ($class, %params) = @_;
    if ($params{'filename'}) {
        open(my $fh, '<', $params{'filename'}) or die "no file";
        $params{'fh'} = $fh;
    }
    return bless \%params, $class;
}

sub next {
    my $class = shift;
    my $fh = $class->{'fh'};
    my $data = <$fh>;
    if ($data) {
        chomp $data;
        return $data, 0;
    } else {
        return undef, 1;
    }
}

sub all {
    my $class = shift;
    my $fh = $class->{'fh'};
    my @data;
    while (my $elem = <$fh>) {
        chomp $elem;
        push @data, $elem;
        
    }
    return \@data;
}

1;
