PDF INTERLEAVING.

This script takes two PDF files as arguments and outputs the first in-
terleaved with the second.

This may be useful if you have several two-sided documents to scan and
a single-sided Automatic Document Feeder Scanner.

Just scan all odd pages to a file and all even ones to another. Then:

pdfinterleave.pl oddpages.pdf evenpages.pdf > fulldocument.pdf

USE: 
	-r If you need to reverse the evenpages file.
	-l If you want to discard the last page of evenpages file.


REQUISITES:

	Perl		- This is a perl program ;)
	PDF::API2	- Perl extension to handle PDFs.


use $cpan PDF::API2 to install that.

