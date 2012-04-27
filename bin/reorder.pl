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

die "$0: São precisos dois arquivos,  primeiro as ímpares, depois as pares\n"
	unless @ARGV == 2;

my $oddfile  = shift;
my $evenfile = shift;

my $new  = PDF::API2->new();
my $odd  = PDF::API2->open($oddfile);
my $even = PDF::API2->open($evenfile);

my $total = $odd->pages() + $even->pages();

die "$0: Arquivos $evenfile $oddfile contém número ímpar de páginas\n"
	unless $total % 2 == 0;

foreach ( 1 .. $total / 2 ) {
    $new->importpage( $odd, $_ ) if $_ % 2 != 0;                  #Ímpar.
    $new->importpage( $even, $_ + $total / 2 ) if $_ % 2 == 0;    #Par.

}

print $new;
