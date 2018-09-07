use 5.006;
use strict;
use warnings;

use DBHandler;
use Parser;
use Encryptor;
use DDP;
use Getopt::Long;
my $OPTS = {};

GetOptions(
    "erase=s"   => \$OPTS->{erase},
    "search=s"   => \$OPTS->{search},
);

my $DB = DBHandler->initDB();

if ($OPTS->{search}) {
    my $startpath = $OPTS->{search};
    
    chomp $startpath;
    while ($startpath =~ m/^\s+$/) {
        $startpath = <>;
        chomp $startpath;
    }

    if ($OPTS->{erase}) {
        $DB->eraseDB();
    }

    Parser->runStart($startpath, $DB);
    Encryptor->encryptDB($DB);
}


# $DB->dumpDB();
warn "START:";
while (my $line = <>) {
    warn "LINE: ", $line;
    my ($path, $accesskey, $processinfo) = split /\s+/, $line;
    next unless $accesskey && $processinfo;
    my $encryptedFile = $DB->select($path);
    if ($accesskey == $encryptedFile->{accesskey} && $processinfo == $encryptedFile->{processinfo}) {
        warn "OK";
    } else {
        warn "WRONG";
    }
    my $file = Encryptor->decrypt($accesskey, $processinfo, $encryptedFile->{encryptedfile});
    p $file;
}
