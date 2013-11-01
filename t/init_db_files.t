#!/usr/bin/env perl

use strict;
use warnings;

use lib qw( ../src ./src );

use Test::More tests => 4;
use IO::Capture::Stdout;
use IO::Capture::Stderr;

use_ok( 'Bibase' );

# test that when bibase.bib isn't there, that an appropriate file is touched
{
    $main::DBFile = "blah.bib";
    $main::altDBFile = "blah.db";
    my $capture = IO::Capture::Stdout->new();
    $capture->start();
    Bibase->init_db_files();
    $capture->stop();

    my $test_stdout = join "", ($capture->read());

    my $expected =<<'EOT';
opening new file blah.bib
opening new file blah.db
EOT
    is( $test_stdout, $expected,
	"Correct init_db_files output when db files don't yet exist" );

    ok( -e $main::DBFile, ".bib file created" );
    ok( -e $main::altDBFile, ".db file created" );

    # clean up
    unlink $main::DBFile;
    unlink $main::altDBFile;
}

# test that when bibase.bib *is* there, that the file is left alone
# test that when bibase.db *is* there, that the file is left alone

# vim: expandtab shiftwidth=4:
