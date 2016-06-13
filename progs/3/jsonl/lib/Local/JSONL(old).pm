package Local::JSONL;

use strict;
use warnings;
use DDP;
use 5.018;

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


sub decode_hash;
our $ch;


sub decode_arr {
    my @makearr;
    my $aref = pop @_; 
    my $val = '';
    $ch = shift(@{$aref});
    while ($ch ne ']') {
        if ($ch eq '[') {
            $val = decode_arr($aref); 
            $ch = shift(@{$aref}); 
        } elsif ($ch eq '{') { 
            $val = decode_hash($aref); 
            $ch = shift(@{$aref}); 
        } else {
            while ($ch ne ',' && $ch ne ']') {
                $val = $val.$ch;
                $ch = shift(@{$aref});
            }
        }
        push (@makearr, $val);
        $val = '';
        if ($ch eq ']') { last }
        else { $ch = shift(@{$aref}) }      
    }
    return \@makearr;
}


sub decode_hash {
    my %makehash;
    my $aref = pop @_;
    my $key = '';
    my $val = '';
    my $flag = 0;
    $ch = shift(@{$aref});
    while ($ch ne '}') {
        while (($ch = shift(@{$aref})) ne '"') {
            $key = $key.$ch;
        }
        shift(@{$aref});
        $ch = shift(@{$aref});
        if ($ch eq '[') { 
            $val = decode_arr($aref); 
            $ch = shift(@{$aref}) 
        } elsif ($ch eq '{') { 
            $val = decode_hash($aref);
            $ch = shift(@{$aref});
        } else {
            while ($ch ne ',' && $ch ne '}') {
                $val = $val.$ch;
                $ch = shift(@{$aref});
            }
        }
       
        unless ($val =~ s/^"(\N+)"$/$1/g) {
        }
        $val =~s/(\N*)\\n(\N*)/$1\n$2/g;
        $makehash{$key} = $val;
        $val = '';
        $key = '';
        if ($ch eq '}') { last }
        else { shift(@{$aref}) }
    }
    return \%makehash;
}


sub decode_jsonl {
    my @arr = split('', $_[0]);
    if ($arr[-1] eq ',') { pop @arr }
    unshift(@arr, '[');
    push(@arr, ']');
    $ch = shift(@arr);
    if ($ch eq '{') {  return decode_hash(\@arr) }
    elsif ($ch eq '[') { return decode_arr(\@arr) }
    return;
}


sub encode_hash;


our $flag = 0;


sub encode_arr {
    my $line = '';
    my $newline;
    for (@_) {
        if ($line) { 
            if ($flag) { $line = $line."\n" }
            else { $line = $line.","} 
        }
        if (ref($_) eq 'ARRAY') { $newline = encode_arr($_) }
        elsif (ref($_) eq 'HASH') { $newline = encode_hash($_) }
        else { 
            $newline = "$_";
        }
        $line = $line.$newline;
    }
    $flag++;
    return "[".$line."]";
}


sub encode_hash {
    my $key;
    my $val;
    my $line = '';
    my $newline;
    my %makehash = %{pop @_};
    while (($key, $val) = each %makehash) {
        if ($line) { $line = $line."," }
        if (ref($val) eq 'ARRAY') { $newline = encode_arr(@{$val}) }
        elsif (ref($val) eq 'HASH') { $newline = encode_hash(%{$val}) }
        else {
            $newline = "\"$val\"";
            $newline =~s/(\N*)\n(\N*)/$1\\n$2/g;
        }
        $line = $line."\"$key\":".$newline;
    }
    return "{".$line."}";
}


sub encode_jsonl {
    my $line = '';
    my $ref = pop @_;
    if (ref($ref) eq 'ARRAY') { $line = encode_arr(@{$ref}) }
    elsif (ref($ref) eq 'HASH') { $line = encode_hash(%{$ref}) }
    else { $line = $line.${$ref} }
    $line =~s/^\[([\{\[].+[\}\]])\]$/$1/ms;
    return $line;
}

1;