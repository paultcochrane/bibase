#!/usr/bin/env perl

use strict;
use warnings;

use lib qw( ../src ./src );

use Test::More tests => 2;
use IO::Capture::Stdout;
use IO::Capture::Stderr;
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
        "Barfs with error message when settings file doesn't exist" );
}

# vim: expandtab shiftwidth=4:
