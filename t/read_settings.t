#!/usr/bin/env perl

use strict;
use warnings;

use lib qw( ../src ./src );

use Test::More tests => 11;
use Capture::Tiny ':all';

use_ok( 'Bibase::Config' );

# it barfs with error message when settings file doesn't exist
{
    my $config = Bibase::Config->new();
    eval {
        $config->read_settings( "blah.settings" );
    };
    my $test_stderr = $@;
    my $expected = "No such file or directory";
    like( $test_stderr, qr/$expected/,
        "barfs with error message when settings file doesn't exist" );
}

# it sets default settings filename when none is given
{
    my $config = Bibase::Config->new();
    eval {
        $config->read_settings();
    };
    my $test_stdout = $@;
    my $expected = "";
    is( $test_stdout, $expected,
        "sets default settings filename when none is given" );
}

# it sets DBFile and altDBFile to the expected default values
{
    my $config = Bibase::Config->new();
    $config->read_settings();
    my $expected_dot_bib = "bibase.bib";
    my $expected_dot_db = "bibase.db";

    my $bibFname = $main::DBFile;
    my $dbFname = $main::altDBFile;

    is( $bibFname, $expected_dot_bib,
        "sets default .bib filename correctly" );
    is( $dbFname, $expected_dot_db,
        "sets default .db filename correctly" );
}

# it sets DBFile and altDBFile to expected input values
{
    my $settings =<<"EOF";
dbfilepath =
bibfilename = blah.bib
dbfilename = blah.db
EOF
    my $settings_fname = "blah.settings";
    open my $fh, ">", $settings_fname or die "$!";
    print $fh $settings;
    close $fh;

    my $config = Bibase::Config->new();
    $config->read_settings( $settings_fname);

    my $bibFname = $main::DBFile;
    my $dbFname = $main::altDBFile;

    my $expected_dot_bib = "blah.bib";
    my $expected_dot_db = "blah.db";

    is( $bibFname, $expected_dot_bib,
        "sets preset .bib filename correctly" );
    is( $dbFname, $expected_dot_db,
        "sets preset .db filename correctly" );

    # clean up
    unlink $settings_fname;
}

# it sets DBFile and altDBFile to expected input values with dbfilepath
{
    my $settings =<<"EOF";
dbfilepath = moo/
bibfilename = blah.bib
dbfilename = blah.db
EOF
    my $settings_dir = "moo/";
    mkdir $settings_dir;
    my $settings_fname = $settings_dir . "blah.settings";
    open my $fh, ">", $settings_fname or die "$!";
    print $fh $settings;
    close $fh;

    my $config = Bibase::Config->new();
    $config->read_settings( $settings_fname);

    my $bibFname = $main::DBFile;
    my $dbFname = $main::altDBFile;

    my $expected_dot_bib = $settings_dir . "blah.bib";
    my $expected_dot_db = $settings_dir . "blah.db";

    is( $bibFname, $expected_dot_bib,
        "sets preset .bib filename with dbfilepath correctly" );
    is( $dbFname, $expected_dot_db,
        "sets preset .db filename with dbfilepath correctly" );

    # clean up
    unlink $settings_fname;
    rmdir $settings_dir;
}

# it sets DBFile and altDBFile to default values with null settings
{
    my $settings =<<"EOF";
dbfilepath =
bibfilename =
dbfilename =
EOF
    my $settings_fname = "blah.settings";
    open my $fh, ">", $settings_fname or die "$!";
    print $fh $settings;
    close $fh;

    my $config = Bibase::Config->new();
    $config->read_settings( $settings_fname);

    my $bibFname = $main::DBFile;
    my $dbFname = $main::altDBFile;

    my $expected_dot_bib = "bibase.bib";
    my $expected_dot_db = "bibase.db";

    is( $bibFname, $expected_dot_bib,
        "sets default .bib filename from null setting correctly" );
    is( $dbFname, $expected_dot_db,
        "sets default .db filename from null setting correctly" );

    # clean up
    unlink $settings_fname;
}

# vim: expandtab shiftwidth=4:
