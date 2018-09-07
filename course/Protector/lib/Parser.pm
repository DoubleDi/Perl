package Parser;

use 5.006;
use strict;
use warnings;

use File::Slurp;
use DDP;
use String::CRC32;

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
                        accesskey     => $self->make_accesskey($dirPath.'/'.$fileName),
                        processinfo   => $self->make_processinfo($dirPath.'/'.$fileName),
                        originalfile  => $holeFile,
                        encryptedfile => '',
                    };
                    warn "Accesskey", $newelem->{accesskey}, "Processinfo", $newelem->{processinfo};
                    push @$filesToAdd, $newelem;
                    last;
                }
            }
            close($file);
        }
    }
    closedir($dir);
}


sub make_processinfo 
{
    my ($self, $path) = @_;
    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks) = stat($path);
    return crc32($uid + $gid + $size);
}

sub make_accesskey
{
    my ($self, $path) = @_;
    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks) = stat($path);
    return crc32($ctime + $mode + $blocks);

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
