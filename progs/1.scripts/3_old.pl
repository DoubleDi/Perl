use strict;
use DDP;
my @a; 
my @F;
my $k = 0;
while (<>) {
    chomp;
    @F = split /:/, $_;
    $k++; 
    for(my $i = 0; $i <= $#F; $i++) { 
        $a[$k - 1][$i] = $F[$i];
    }
}
p @a;

