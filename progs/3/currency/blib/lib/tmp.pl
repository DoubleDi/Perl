use strict;
use warnings;
use DDP;
use 5.018;

use Local::Currency qw(set_rate);

set_rate({
    rur => 1,
    usd => 60,
    eur => 70,
});

say Local::Currency::rur_to_rur(42);
say Local::Currency::rur_to_usd(120);
say Local::Currency::eur_to_usd(42);
