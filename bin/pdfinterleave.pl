#!/usr/bin/perl 
#===============================================================================
#
#         FILE: pdfinterleave.pl
#
#        USAGE: ./pdfinterleave.pl oddpages.pdf evenpages.pdf
#
#  DESCRIPTION: Interleaves the pages of two pdf files.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: WELTON RODRIGO TORRES NASCIMENTO (rodrigo@familianascimento.org)
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 27-04-2012 14:22:51
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use PDF::API2;
use Data::Dumper;
use Getopt::Long;

my $oddfile;
my $evenfile;
my $norevert;
my $discardlast;

GetOptions(
    "r"   => \$norevert,
    "l"   => \$discardlast,
);

my $new  = PDF::API2->new();
my $odd  = PDF::API2->open(shift);
my $even = PDF::API2->open(shift);

my $total = $odd->pages() + $even->pages();

die "$0: Files\n$evenfile\n$oddfile\ncontains a different number of pages.\n"
	unless $total % 2 == 0;

my $i = 1;
while ( $i <= $total / 2 ) {
    $new->importpage( $odd, $i );
    if ( not defined $norevert ) {
		# Discard last page of the even file. (usually blank).
		last if defined $discardlast and $even->pages() - $i == 0;

		# Interleaves second file in reverse order. (facilitate scanning).
        $new->importpage( $even, $even->pages() + 1 - $i );
    }
    else {
		last if defined $discardlast and $even->pages() == $i;
        $new->importpage( $even, $i );
    }
    $i++;
}

$new->saveas("-");
