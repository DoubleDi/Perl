use strict;
use DDP;
my @a; 
while (<>) {
    chomp;
    my @F = split /:/, $_;
    push(@a, \@F);
}
p @a;
