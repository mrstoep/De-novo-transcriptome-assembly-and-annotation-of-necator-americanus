#!/bin/bash

#Set to exit loop if there is error in code
#Set to show each command before it is executed

set -e
set -x

#defining output file and input file
input_file1=./output/mmseqs/thinned_assembly.fasta
input_file2=./output/trinity/salmon_outdir/quant.sf
singularity_image=./trinityrnaseq_latest.sif

#path to trnitystats.pl
TrinityStats=/usr/local/bin/util/TrinityStats.pl

#Perform exN50 calculation
singularity exec $singularity_image $TrinityStats $input_file1 --salmon $input_file2
