use 5.006;
use strict;
use warnings;

use DBHandler;
use Parser;
use Encryptor;
use DDP;

my $startpath = <>;
chomp $startpath;
while ($startpath =~ m/^\s+$/) {
    $startpath = <>;
    chomp $startpath;
}

my $DB = DBHandler->initDB();
$DB->eraseDB();
Parser->runStart($startpath, $DB);
Encryptor->encryptDB($DB);

$DB->dumpDB();
warn "START:";
while (my $line = <>) {
    my ($path, $accesskey, $processinfo) = split /\s/, $line;
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
