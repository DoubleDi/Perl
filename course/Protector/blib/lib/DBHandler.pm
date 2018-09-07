package DBHandler;

use 5.006;
use strict;
use warnings;
use DDP;
use DBD::mysql;

sub initDB 
{
    my ($self) = @_;
    my $dbh = DBI->connect("DBI:mysql:database=protector_database;", "root");
    $dbh->ping();
    $dbh->{mysql_auto_reconnect} = 1;
    return bless { DB => $dbh }
}

sub updateEncrypted 
{
    my ($self, $obj) = @_;
    my $sth = $self->{DB}->prepare("update unprotected_files set encryptedfile = ? where path = ?;");
    $sth->execute($obj->{encryptedfile}, $obj->{path});
}

sub insert 
{
    my ($self, $objs) = @_;
    for (@$objs) {
        eval {
            my $sth = $self->{DB}->prepare("insert into unprotected_files (path, accesskey, processinfo, originalfile, encryptedfile) values (?, ?, ?, ?, ?)");
            $sth->execute($_->{path}, $_->{accesskey}, $_->{processinfo}, $_->{originalfile}, $_->{encryptedfile});
        };
        if ($@) {
            warn $@;
        }
        warn $_->{path};
    }
}

sub select 
{
    my ($self, $path) = @_;
    my $sth = $self->{DB}->prepare("select * from unprotected_files where path = ?");
    $sth->execute($path);
    return $sth->fetchrow_hashref();
}

sub selectMulti 
{
    my ($self, $paths) = @_;
    my $qs = '';
    $qs = $qs . ', ?' for (@$paths);
    $qs =~ s/^\,\s//;
    my $sth = $self->{DB}->prepare("select * from unprotected_files where path in (".$qs.")");
    $sth->execute(@$paths);
    return $sth->fetchall_arrayref({});
}

sub selectAll 
{
    my ($self, $limit) = @_;
    $limit ||= 1000;
    my $sth = $self->{DB}->prepare("select * from unprotected_files limit ?");
    $sth->execute($limit);
    return $sth->fetchall_arrayref({});
}

sub delete 
{
    my ($self, $path) = @_;
    my $sth = $self->{DB}->prepare("delete from unprotected_files where path = ?");
    return $sth->execute($path);
}

sub eraseDB 
{
    my ($self) = @_;
    return $self->{DB}->do("delete from unprotected_files");
}

sub getParamsByPath 
{
    my ($self, $path) = @_;
    my $sth = $self->{DB}->prepare("select accesskey, processinfo from unprotected_files where path = ?");
    $sth->execute($path);
    return $sth->fetchrow_arrayref();
}

sub dumpDB
{
    my ($self) = @_;
    my $all = $self->selectAll();
    p $all;
}
1;
