package Local::Currency;

use strict;
use warnings;
use 5.018;

=encoding utf8

=head1 NAME

Local::Currency - currency converter

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

    use Local::Currency qw(set_rate);
    set_rate(
        usd => 1,
        rur => 65.44,
        eur => 1.2,
        # ...
    );

    my $rur = Local::Currency::usd_to_rur(42);
    my $cny = Local::Currency::gbp_to_cny(30);

=cut

use Exporter 'import';
our @EXPORT = qw(set_rate);

our %set_hash;

sub AUTOLOAD {
    our $AUTOLOAD;
    unless ($AUTOLOAD =~ m/::([^:]+)_to_([^:]+)/) { die 'Undefined subroutine &'.$AUTOLOAD }
    unless (exists $set_hash{$1}) {die 'Use of uninitialized value '.$1.' in hash element &' }
    unless (exists $set_hash{$2}) {die 'Use of uninitialized value '.$2.' in hash element &' }
    return $set_hash{$1} * shift(@_) / $set_hash{$2};
}

sub set_rate {
   my $href = shift @_;
   %set_hash = (%set_hash, %{$href});
   1;
}

1;
