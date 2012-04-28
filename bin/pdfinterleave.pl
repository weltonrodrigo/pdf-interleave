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

my $revert;
my $discardlast;

GetOptions(
    "r"   => \$revert,
    "l"   => \$discardlast,
);

my $new  = PDF::API2->new();
my $odd  = PDF::API2->open(shift);
my $even = PDF::API2->open(shift);

my $opages =  $odd->pages();
my $epages = $even->pages();

my $max    = $opages > $epages? $opages : $epages;

PAGE:
for (my $i = 1; $i <= $max; $i++){
	my $page = $i;

	# One from odd
	$new->importpage($odd,  $page) unless $i > $opages;

	# Reverse even?
	$page = $epages + 1 - $i if defined $revert; 
	
	# Discard last?
	next PAGE if $discardlast and $i == $epages;

	# One from even
	$new->importpage($even, $page ) unless $i > $epages;
}

$new->saveas("-");
