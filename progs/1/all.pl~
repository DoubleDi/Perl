1)ls -l | perl -lna -e 'BEGIN { my $all = 0; my $bigger = 0 }; $all++; if ($F[4] > 2**20) { print $F[8]; $bigger++; } END { print "all: ".$all; print "bigger: ".$bigger }'
2)perl -nlaF":" -e '$k++;  for(my $i = 0; $i <= $#F; $i++) { if ($F[$i] > 10)  { print +($k - 1)." ".$i}};' test2.txt


