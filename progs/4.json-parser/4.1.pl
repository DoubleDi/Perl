use DDP;
use feature "say";

#добить \\
#рекурсивные регулярки

sub decode_str 
{
    my $data = shift;
    $data =~ s/^"(.+)"$/$1/;
    $data =~ s/(^\\)?\\\\/\\/g;
    $data =~ s/(^\\\\)?\\\"/\"/g;
    $data =~ s/\\n/\n/g;
    $data =~ s/\\u(\d{1,4})/ pack 'U*', hex($1)/eg;
    return $data
}

sub decode_arr 
{
    my $data = shift;
    say "lal----".$data;
    my @arr;
    while ($data =~ /
        \s*
        (                   
        [\{]                   
            (?:
                [^\"\{\}]++    
                  |
                (?1)
            )*
        [\}]
        | 
        [\[]                   
            (?:
                [^\"\[\]]++    
                  |
                (?1)
            )*
        [\]]
        |
        "(?:[^"\\]++|\\.)*+"
        | 
        -?[\d.]+     
        )\s*         
        /gx) {
        say "---".$1;
        my $elem = $1;
        p $elem;
        if ($elem =~ /^\s*\[(.+)\]\s*$/s) { push @arr, decode_arr($1) }
        elsif ($elem =~ /^\s*\{(.+)\}\s*$/s) { push @arr, decode_hash($1) }
        else { 
            $elem = decode_str($elem);
            push @arr, $elem; 
        }
        say "lal----".$data;
    }
    return \@arr;
}

sub decode_hash 
{
    my $data = shift;
    my %hash;
#     while ($data =~ /\s*(\" .+?\"):\s*(\[.+?\]|\{.+?\}|.+?),/gs) {
    while ($data =~ /\s*(\".+?\")\s*:\s*
        (                   
        [\{]                   
            (?:
                [^\"\{\}]++    
                  |
                (?2)
            )*
        [\}]
        | 
        [\[]                   
            (?:
                [^\"\[\]]++    
                  |
                (?2)
            )*
        [\]]
        | 
        "(?:[^"\\]++|\\.)*+"
        | 
        -?[\d.]+     
        )\s*         
        /gx) {
        say "---".$1;
        say "aaa---".$2;
        my $key = decode_str($1);
        my $val = $2;
        if ($val =~ /^\[(.+)\]$/s) { $hash{$key} = decode_arr($1) }
        elsif ($val =~ /^\{(.+)\}$/s) { $hash{$key} = decode_hash($1) }
        else { 
            $val = decode_str($val);
            $hash{$key} =  $val; 
        }
    }
    return \%hash;
}



sub decode_json 
{
    my $data = shift;
    my $result;
    if ($data =~ /^\s*\{(.+)\}\s*$/s) { $result = decode_hash($1) }
    elsif ($data =~ /^\s*\[(.+)\]\s*$/s) { $result = decode_arr($1) }
    return $result;
}

my $data = do { # чтение файла
    open my $f,'<:raw',$ARGV[0]
    or die "open `$ARGV[0]' failed: $!";
    local $/; <$f>
};      


my $struct = decode_json($data);
p $struct;