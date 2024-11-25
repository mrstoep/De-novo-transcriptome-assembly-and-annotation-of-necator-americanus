#!/bin/bash

#Set to exit loop if there is error in code
#Set to show each command before it is executed

set -e
set -x

#defining output file and input file
input_file=./output/mmseqs/thinned_assembly.fasta
output_file=./output/busco/test/
busco_image=busco.sif


#Running busco pipeline
singularity exec $busco_image busco -i $input_file -o $output_file -f -l nematoda_odb10 -m transcriptome
