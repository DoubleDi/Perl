package Local::perlxs;

use 5.010001;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Local::perlxs ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
distance_point
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(

);

our $VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Local::perlxs::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('Local::perlxs', $VERSION);

sub get_points {
	my( $num ) = @_;
	if( !$num )      { return 1,1,1,3 }
	elsif($num == 1) { return 1,1 }
	elsif($num == 2) { return 1,3 }
	else {die "Point $num not available"}
}

sub get_points_2 {
	my( $num ) = @_;
	if( !$num )      { return 1,1,1,6 }
	elsif($num == 1) { return 1,1 }
	elsif($num == 2) { return 1,6 }
	else {die "Point $num not available"}
}
use DDP;
sub multiply_matrix_perl {
    my ($left, $right) = @_;
    my $left_row = @{$left};
    my $left_col = @{$left->[0]};
    my $right_row = @{$right};
    my $right_col = @{$right->[0]};
    unless ($left_col == $right_row) {
        warn "wrong size matrix\n";
        return [];
    }
    my $result = [];
    for my $i (0..($left_row - 1)) {
        for my $k (0..($right_col - 1)) {
            for my $j (0..($left_col - 1)) {
                $result->[$i][$k] += $left->[$i][$j] * $right->[$j][$k];
            }
        }
    }
    return $result;
}

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Local::perlxs - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Local::perlxs;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Local::perlxs, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>a.u.thor@a.galaxy.far.far.awayE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.20.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
