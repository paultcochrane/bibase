#!/usr/bin/env perl

use strict;
use warnings;

use lib qw( ../src ./src );

use Test::More tests => 6;
use IO::Capture::Stdout;
use IO::Capture::Stderr;

use_ok( 'Bibase' );
use_ok( 'Bibase::Config' );

# test that when bibase.bib isn't there, that an appropriate file is touched
{
    my $config = Bibase::Config->new();
    $config->read_settings;

    $config->bibFname( "blah.bib" );
    $config->dbFname( "blah.db" );
    my $capture = IO::Capture::Stdout->new();
    $capture->start();
    my $bibase = Bibase->new();
    $bibase->init_db_files( $config );
    $capture->stop();

    my $test_stdout = join "", ($capture->read());

    my $expected =<<'EOT';
opening new file blah.bib
opening new file blah.db
EOT
    is( $test_stdout, $expected,
	"Correct init_db_files output when db files don't yet exist" );

    ok( -e $config->bibFname, ".bib file created" );
    ok( -e $config->dbFname, ".db file created" );

    # clean up
    unlink $config->bibFname;
    unlink $config->dbFname;
}

# test that when bibase.bib *is* there, that the file is left alone
{
    my $config = Bibase::Config->new();
    $config->read_settings;

    $config->bibFname( "blah.bib" );
    $config->dbFname( "blah.db" );

    # touch the files so that they exist
    open my $bib_fh, ">", $config->bibFname; close $bib_fh;
    open my $db_fh, ">", $config->dbFname; close $db_fh;

    my $capture = IO::Capture::Stdout->new();
    $capture->start();
    my $bibase = Bibase->new();
    $bibase->init_db_files( $config );
    $capture->stop();

    my $test_stdout = join "", ($capture->read());

    my $expected = '';
    is( $test_stdout, $expected,
	"No output expected when db files already exist" );

    # clean up
    unlink $config->bibFname;
    unlink $config->dbFname;
}

# vim: expandtab shiftwidth=4:
