#!/usr/bin/perl
use strict;

# Construct TSV with 2 columns:
# CDD tag_id and Domain name
# It works with smp files from CDD database
# AJPerez, 2019/10/19

# Mapping file
open OUTFILE, ">mapping_smp.tsv";

# Get smp files in smp folder
my @smp = <smp/*.smp>;
foreach my $file (@smp) {
  print "$file\n";

  open INFILE, $file;
  while (<INFILE>) {
    chomp;

    if (/^          tag id ([0-9]+)/) {
      print OUTFILE "$1\t";
    } elsif (/        title /) {
      my ($name) = (split/, /)[1];
      print OUTFILE "$name\n";
    }
  }
  close INFILE;
}

close OUTFILE;
