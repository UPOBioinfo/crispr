# crispr
Scripts and protocols to search for cas proteins and CRISPR sequences

Files preparation
>ls *.smp > cdd_crispr.pn  
>makeprofiledb -in cdd_crispr.pn -title cdd_crispr -dbtype 'rps'  
>perl constructMappingCDD.pl  

Cas finding
>rpsblast+ -query proteins.faa -db cdd_crispr.pn -evalue 1e-05 -outfmt '6 qseqid sseqid pident qcovs qcovhsp length qlen slen evalue qstart qend sstart send' -max_target_seqs 1' -out output.blast  
>perl filterRPSBlastOutput.pl output.blast  
