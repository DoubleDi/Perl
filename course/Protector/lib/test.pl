use Crypt::OpenSSL::Random;
use Crypt::OpenSSL::RSA;
use Crypt::OpenSSL::Bignum;
use MIME::Base64;
use DDP;
use Math::Prime::Util;
use Math::BigInt;

sub exponentiate {
    my ($a, $b, $n) = @_;
    my $res = 1;
    while ($b > 0) {
        if ($b % 2 == 1) {
            $res = $res * $a;
            $b--;
        } else {
            $a = ($a * $a) % $n;
            $b /= 2;
        }
        $res = $res % $n;
    }
    return $res;
}

my $xxx = 3556777;
my $p = Math::BigInt->new(Math::Prime::Util::next_prime(Math::BigInt->new($xxx x 10)));
my $q = Math::BigInt->new(Math::Prime::Util::next_prime(Math::BigInt->new(2578777 x 10)));
my $n = Math::BigInt->new($p * $q);
my $phi_n = Math::BigInt->new(($p - 1) * ($q - 1));
my $e = Math::BigInt->new(Math::Prime::Util::prev_prime($n));
my ($d) = Math::Prime::Util::gcdext($e, $phi_n);
$d = Math::BigInt->new("$d");
$d = $d % $phi_n;

if (($e * $d) % $phi_n != 1) {
    die "WTF?!?!?";
}





my $ss = "abcdefghijklmnop" x 10;
my $newss = "";
my @aa = grep { $_ } split /(.{9})/, $ss;
p @aa;
my @endaa;
my $cc = '';
for my $s (@aa) {
    
    $m = Math::BigInt->new();
    pop @{$m->{value}};
    my @a = map { ord($_) } split '', $s;
    while (scalar @a) {
        my $a = shift @a;
        my $b = shift @a;
        my $c = shift @a;
        my $x = sprintf( "%03d%03d%03d", $a, $b, $c);
        push @{$m->{value}}, $x;
    }
    # p $m;
    my $c = exponentiate($m, $e, $n);
    $cc .= $c;
    push @endaa, $c; 
    # warn $c;
    # warn $c->length;
} 
# warn $cc;
# p @aa;
# p @endaa;
$e = $endaa[13];
p $e;
warn $e->as_number;
map { warn scalar split '', $_->as_number } @endaa;

my $l = join '', map { $_->as_number . "*" } @endaa;
# warn $l;
my @endendaa = ();
my $tmp = length ''.$n;

@aa = grep { $_ } split /\*/, $l;
@aa = map { Math::BigInt->new($_) } @aa;
# p @aa;
# @aa = map { Math::BigInt->new($_->as_number) } @aa;
$e = $aa[13];
p $e;
warn $e->as_number;
warn scalar split '', $e->as_number;

for my $c (@aa) {
    my $newm = exponentiate($c, $d, $n); 

    # warn $newm;
    my $a;
    for (@{$newm->{value}}) {
        $_ =~ m/^(.+)(.{3})(.{3})$/;
        $a = $a . chr($1) ;
        $a = $a . chr($2) ;
        $a = $a . chr($3) ;
    }
    # warn $a;
    $newss .= $a;
    push @endendaa, $a;
}
# warn $newss;
p @endendaa;
@endendaa = map { s/(\0)*$//; $_ } @endendaa;
p @endendaa;
# warn $ss;
