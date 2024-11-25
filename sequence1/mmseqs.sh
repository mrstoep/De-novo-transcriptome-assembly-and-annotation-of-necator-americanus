#!/bin/bash

#Set to exit loop if there is error in code
#Set to show each command before it is executed

set -e
set -x


#Creating output & input directories
input_dir=./output
output_dir=./output/mmseqs

# Create the output directory if it doesn't exist
mkdir -p $output_dir

#Creating mmseqs database
mmseqs createdb $input_dir/trinity.Trinity.fasta $output_dir/assembly_db

#Clustering the seqeunces
mmseqs linclust $output_dir/assembly_db $output_dir/clustered_db tmp_dir --min-seq-id 0.95 -c 0.9

#Extracting representative sequences
mmseqs result2repseq $output_dir/assembly_db $output_dir/clustered_db $output_dir/representative_db

#converting representative_db into FASTA format
mmseqs result2flat $output_dir/assembly_db $output_dir/assembly_db $output_dir/representative_db $output_dir/thinned_assembly.fasta
