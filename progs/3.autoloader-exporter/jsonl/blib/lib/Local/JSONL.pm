package Local::JSONL;

use strict;
use warnings;
use DDP;
use 5.018;
use JSON;

=encoding utf8

=head1 NAME

Local::JSONL - JSON-lines encoder/decoder

=head1 VERSION

Version 1.00

=cut

our $VERSION = '1.00';

=head1 SYNOPSIS

    use Local::JSONL qw(
        encode_jsonl
        decode_jsonl
    );

    $string = encode_jsonl([
        {a => 1},
        {b => 2},
    ]);

    $array_ref = decode_jsonl(
        '{"a":1}' + "\n" +
        '{"b":2}'
    );

=cut

use Exporter 'import';
our @EXPORT = qw(decode_jsonl encode_jsonl);


sub decode_jsonl {
    my $arg = shift @_;
    $arg =~ s/\r\n/\n/;
    my @input = split('\n', $arg);
    my @ret;
    for (@input) {
        if ($_=~ m/^[^{[]/) { push(@ret, $_) }
        else { push(@ret, decode_json($_)) }
    }
    return \@ret;
}


sub encode_jsonl {
    my $arg = shift @_;
    my $jsonl = '';
    for (@{$arg}) {
        if ($jsonl) { $jsonl = $jsonl."\n" }
        if (ref(\$_) eq 'SCALAR') { $jsonl = $jsonl.$_ }
        else { $jsonl = $jsonl.(encode_json($_)) } 
    }
    return $jsonl;
}

1;