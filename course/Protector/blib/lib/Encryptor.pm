package Encryptor;

use 5.006;
use strict;
use warnings;

use DBHandler;
use Crypt::OpenSSL::RSA;
use Crypt::OpenSSL::Bignum;
use MIME::Base64;
use Math::Prime::Util;
use Math::BigInt;
use DDP;

sub exponentiate 
{
    my ($self, $a, $b, $n) = @_;
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

sub encryptDB 
{
    my ($self, $DB) = @_;
    warn "Start select";
    my $rows = $DB->selectAll();
    warn "End select";
    for (@$rows) {
        $_->{encryptedfile} = $self->encrypt($_->{accesskey}, $_->{processinfo}, $_->{originalfile});
        $DB->updateEncrypted($_);
        warn $_->{path};
    }
}

sub getEncryptParams 
{
    my ($self, $key, $info) = @_;
    my $p = Math::Prime::Util::next_prime($key x 10);
    my $q = Math::Prime::Util::next_prime($info x 10);
    my $n = Math::BigInt->new($p * $q);
    my $phi_n = Math::BigInt->new(($p - 1) * ($q - 1));
    my $e = Math::BigInt->new(Math::Prime::Util::prev_prime($phi_n));
    my ($d) = Math::Prime::Util::gcdext($e, $phi_n);
    $d = Math::BigInt->new("$d");
    $d = $d % $phi_n;

    if (($e * $d) % $phi_n != 1) {
        die "WTF?!?!?";
    }
    return ($e, $n, $d);
}

sub encrypt 
{
    my ($self, $key, $info, $file) = @_;
    my ($e, $n, $d) = $self->getEncryptParams($key, $info);
    my @splitedFile = grep { $_ } split /(.{9})/, $file;
    
    my @encryptedFile;
    for my $s (@splitedFile) {        
        my $binFile = Math::BigInt->new();
        pop @{$binFile->{value}};
        my @a = map { ord($_) } split '', $s;
        while (scalar @a) {
            my $a = shift @a;
            my $b = shift @a;
            my $c = shift @a;
            push @{$binFile->{value}}, sprintf( "%03d%03d%03d", $a||0, $b||0, $c||0);
        }
        my $c = $self->exponentiate($binFile, $e, $n);
        push @encryptedFile, $c; 
    } 
    
    return join '', map { $_->as_number . "*" } @encryptedFile;
}

sub decrypt
{
    my ($self, $key, $info, $encryptedFile) = @_;
    my ($e, $n, $d) = $self->getEncryptParams($key, $info);
    my @binFile = map { Math::BigInt->new($_) } grep { $_ } split /\*/, $encryptedFile;

    my @ordinaryFile = ();
    for my $c (@binFile) {
        my $decrypted = $self->exponentiate($c, $d, $n); 
        my $a = '';
        for (@{$decrypted->{value}}) {
            $_ =~ m/^(.+)(.{3})(.{3})$/;
            $a = $a . chr($1) . chr($2) . chr($3);
        }
        push @ordinaryFile, $a;
    }
    return join '', map { s/(\0)*$//; $_ } @ordinaryFile;
}

sub buildParamsOnPath 
{
    my ($self, $path) = @_;
}

1;
