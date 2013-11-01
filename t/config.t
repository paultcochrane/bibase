#!/usr/bin/env perl

use strict;
use warnings;

use lib qw( ../src ./src );

use Test::More tests => 2;
use Capture::Tiny ':all';

use_ok( 'Bibase::Config' );

# it returns the DBFile name
{
    my $config = Bibase::Config->new();
    $config->read_settings();
    
    my $bibFname = $config->bibFname;
    my $expected = "bibase.bib";
    is( $bibFname, $expected,
	"returns the DBFile name" );
}

# vim: expandtab shiftwidth=4:
