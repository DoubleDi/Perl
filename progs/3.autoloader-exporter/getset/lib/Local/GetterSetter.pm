package Local::GetterSetter;

use strict;
use warnings;
use 5.018;

=encoding utf8

=head1 NAME

Local::GetterSetter - getters/setters generator

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

    package Local::SomePackage;
    use Local::GetterSetter qw(x y);

    set_x(50);
    print our $x; # 50

    our $y = 42;
    print get_y(); # 42
    set_y(11);
    print get_y(); # 11

=cut



use Exporter qw(import);

  sub import {
     my ($class, @fields) = @_;
  
     my $package = caller();
     no strict;
     while (@fields) {
         my $func = shift @_;
         my $f = "${package}::set_${func}";
         *{$f} = sub {
             *{"${package}::${func}"} = \(shift @_);
         };
         $f = "${package}::get_${func}";
         *{$f} = sub {
             return ${"${package}::${func}"};
         };
#          eval ("*$package"."::set_$func = sub {
#              *$package"."::$func =".' \(shift @_);
#          }');
#          eval ("*$package"."::get_$func = sub {
#              return "."\$"."$package"."::$func
#          }");
     }
  }

1;

