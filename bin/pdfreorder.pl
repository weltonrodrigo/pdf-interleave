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
use Getopt::Long;

my $oddfile;
my $evenfile;
my $norevert;
my $keeplast;

GetOptions(
    "r"   => \$norevert,
    "l"   => \$keeplast,
);

my $new  = PDF::API2->new();
my $odd  = PDF::API2->open(shift);
my $even = PDF::API2->open(shift);

my $total = $odd->pages() + $even->pages();

die "$0: Arquivos $evenfile $oddfile contém número ímpar de páginas\n"
	unless $total % 2 == 0;

my $i = 1;
while ( $i <= $total / 2 ) {
    $new->importpage( $odd, $i );
    if ( not defined $norevert ) {
		# Descartar a última página do conjunto par (normalmente em branco).
		last if not defined $keeplast and $even->pages() - $i == 0;
		# Mesclar o segundo arquivo na ordem reversa.
        $new->importpage( $even, $even->pages() + 1 - $i );
    }
    else {
		last if not defined $keeplast and $even->pages() == $i;
        $new->importpage( $even, $i );
    }
    $i++;
}

$new->saveas("-");
