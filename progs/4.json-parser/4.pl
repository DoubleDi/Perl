use strict;
use warnings;
use feature "say";
use DDP;



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

sub decode_json {
    my $data = shift;
    $data =~ s/(\"\s*):(\s*[\"-\{\[\d])/$1=>$2/g;
#     $data =~ s/
#     (?<json>
#         [\{\[]] 
#             (?:[^{}"']+
#             |["']
#                 (?:[^\\"']+
#                 |\\.
#                 )*
#             |(?&json)
#             )* 
#         [\}\]]
#     )
#     /$data = "($+{json})"
#     /egx;
    return eval($data);
}


my $data = do { # чтение файла
    open my $f,'<:raw',$ARGV[0]
    or die "open `$ARGV[0]' failed: $!";
    local $/; <$f>
};

my $struct = decode_json($data);
p $struct;