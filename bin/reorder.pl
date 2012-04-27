#!/usr/bin/perl 
#===============================================================================
#
#         FILE: reorder.pl
#
#        USAGE: ./reorder.pl  
#
#  DESCRIPTION: Reorganiza arquivos PDF frente e verso que foram escaneados um 
#  				lado de cada vez.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: WELTON RODRIGO TORRES NASCIMENTO (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 27-04-2012 14:22:51
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use PDF::API2;
use Data::Dumper;

my $infile = shift;

my $new  = PDF::API2->new();
my $pdf = PDF::API2->open($infile);

my $total = $pdf->pages();

die "$0: Arquivo $infile contém número ímpar de páginas\n"
	unless $total % 2 == 0;

foreach(1..$total/2){
	$new->importpage($pdf, $_			   ) if $_ % 2 != 0; #Ímpar.
	$new->importpage($pdf, $_ + $total / 2 ) if $_ % 2 == 0; #Par.

}

print $new;
