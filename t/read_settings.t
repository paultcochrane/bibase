#!/usr/bin/env perl

use strict;
use warnings;

use lib qw( ../src ./src );

use Test::More tests => 3;
use Capture::Tiny ':all';

use_ok( 'Bibase' );

# it barfs with error message when settings file doesn't exist
{
    my $bibase = Bibase->new();
    eval {
        $bibase->read_settings( "blah.settings" );
    };
    my $test_stderr = $@;
    my $expected = "No such file or directory";
    like( $test_stderr, qr/$expected/,
        "barfs with error message when settings file doesn't exist" );
}

# it sets default settings filename when none is given
{
    my $bibase = Bibase->new();
    eval {
        $bibase->read_settings();
    };
    my $test_stdout = $@;
    my $expected = "";
    is( $test_stdout, $expected,
        "sets default settings filename when none is given" );
}

# vim: expandtab shiftwidth=4:
