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
my $revert = 1;

GetOptions( "i=s" => \$oddfile, 
			"p=s" => \$evenfile, 
			"r"   => \$revert, 
		);

die "$0: São precisos dois arquivos,  primeiro as ímpares, depois as pares\n"
	unless @ARGV >= 2;


my $new  = PDF::API2->new();
my $odd  = PDF::API2->open($oddfile);
my $even = PDF::API2->open($evenfile);

my $total = $odd->pages() + $even->pages();

die "$0: Arquivos $evenfile $oddfile contém número ímpar de páginas\n"
	unless $total % 2 == 0;

my $i = 1;
while ( $i <= $total / 2 ) {
    $new->importpage( $odd, $i );
    if ( defined $revert ) {
		# Mesclar o segundo arquivo na ordem reversa.
        $new->importpage( $even, $even->pages() + 1 - $i );
    }
    else {
        $new->importpage( $even, $i );
    }
    $i++;
}

$new->saveas("-");