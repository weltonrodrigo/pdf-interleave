PDF INTERLEAVING.

This script takes two PDF files as arguments and outputs the first in-
terleaved with the second.

This may be useful if you have several two-sided documents to scan and
a single-sided Automatic Document Feeder Scanner.

Just scan all odd pages to a file and all even ones to another. Then:

pdfinterleave.pl oddpages.pdf evenpages.pdf > fulldocument.pdf
