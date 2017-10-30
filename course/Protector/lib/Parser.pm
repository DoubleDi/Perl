package Parser;

use 5.006;
use strict;
use warnings;

use File::Slurp;
use DDP;

our $filesToAdd = [];

sub PARSE_REGEX 
{
    qw/
        pass
        key
        encrypt
    /;
}


sub parseDir 
{
    my ($self, $dirPath) = @_;
    my $dir;
    opendir($dir, $dirPath);
    my $file;
    while (my $fileName = readdir($dir)) {
        next if $fileName eq '.' || $fileName eq '..' || $fileName eq '.DS_Store' ;
        if (-d "$dirPath/$fileName") {
            $self->parseDir("$dirPath/$fileName");
        } else {
            next if -B "$dirPath/$fileName";
            open($file,"<", "$dirPath/$fileName");
            my $desc;
            while (my $fileLine = <$file>) {
                if (scalar grep { $fileLine =~ m/$_/i; } PARSE_REGEX) {
                    open(my $fh,"<", "$dirPath/$fileName");
                    my $holeFile = '';
                    while (my $l = <$fh>) { $holeFile .= $l }; 
                    my $newelem = {
                        path          => "$dirPath/$fileName",
                        accesskey     => (stat "$dirPath/$fileName")[4] + (stat "$dirPath/$fileName")[5],
                        processinfo   => (stat "$dirPath/$fileName")[2],
                        originalfile  => $holeFile,
                        encryptedfile => '',
                    };
                    push @$filesToAdd, $newelem;
                    last;
                }
            }
            close($file);
        }
    }
    closedir($dir);
}


sub runStart 
{
    my ($self, $path, $DB) = @_;
    $filesToAdd = [];
    $self->parseDir($path);
    warn scalar @$filesToAdd;
    $DB->insert($filesToAdd);
    warn "DONE!!!!";
}

sub waveSearch 
{
    
}

1;
