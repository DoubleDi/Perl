#!/usr/bin/env perl -lna
BEGIN { $all = 0; $bigger = 0 }; $all++; if ($F[4] > 2**20) { print $F[8]; $bigger++; } END { print "all: ".$all; print "bigger: ".$bigger }
