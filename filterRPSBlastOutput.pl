#!/usr/bin/perl
use strict;

# Filter RPSBlast output:
# rpsblast+ -query pan_gn.faa -db cdd_crispr.pn -evalue 1e-05 
#   -outfmt '6 qseqid sseqid pident qcovs qcovhsp length qlen slen evalue qstart qend sstart send' -max_target_seqs 1'
# AJPerez, 2019/10/19

# Thresholds
my $ID = $ARGV[1] || 25; # identity
my $SC = $ARGV[2] || 70; # subject (CDD Domain) coverage

# Gather smp mapping
my %smp;
open SMP, "./mapping_smp.tsv";
while (<SMP>) {
  chomp;

  my ($smp, $name) = split/\t/;
  $smp{$smp} = $name;
}
close SMP;

# Check rpsblast file
die "Please. give me a rpsblast output as argument" if !$ARGV[0];
open INFILE, $ARGV[0];
while (<INFILE>) {
  chomp;

  my ($qseqid, $sseqid, $pident, $qcovs, $qcovhsp, $length, $qlen, $slen, $evalue, $qstart, $qend, $sstart, $send) = split/\t/;
  my ($n) = (split/\|/, $sseqid)[2];
  my $scov = ($length / $slen) * 100;

  next unless ($scov >= $SC && $pident >= $ID);
  #print "$_\n";
  print "$qseqid\t$smp{$n}\n";
}
close INFILE;
