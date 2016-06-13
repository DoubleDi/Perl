use strict;
use warnings;
use 5.018;
use DDP;


    my @a = split(['{[]}'],  qq<{"a":[1,2,3]}\n{"b":"X\\n"}>);
    p @a;