package PerlIO::via::Numerator;

our $number;

sub PUSHED
{
    my ($class,$mode,$fh) = @_;
    my $buf = '';
    return bless \$buf,$class;
}

sub FILL
{
    my ($obj,$fh) = @_;
    my $line = <$fh>;
    $line =~ s/^\d+?\.(.+)?/$1/;
    return $line;
}

sub WRITE
{
    my ($obj,$buf,$fh) = @_;
    $number++;
    $buf = "$number.".$buf;
    print $fh $buf or die "error printing";
    return length($buf);
}

sub FLUSH
{
    my ($obj,$fh) = @_;
    print $fh $$obj or return -1;
    $$obj = '';
    return 0;
}
1;