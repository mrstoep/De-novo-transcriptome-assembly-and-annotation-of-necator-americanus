#!/bin/bash

#Exit if there is error in loop
#display each command before it is executed
set -e
set -x

#defining directories + making output directory
input_dir=./output/trimmomatic
output_dir=./output/trinity

mkdir -p $output_dir

# Get list of input files
input_files1=("$input_dir"/*_1_P.fastq.gz)
input_files2=("$input_dir"/*_2_P.fastq.gz)

# Trinity running for each pair of input files
for i in "${!input_files1[@]}"; do
    # Extract the base filename without extension
    base_filename=$(basename "${input_files1[$i]}" _1_P.fastq.gz)

    # Run Trinity with left and right read files
    Trinity \
    --seqType fq \
    --SS_lib_type RF \
    --max_memory 2G \
    --CPU 2 \
    --left "${input_files1[$i]}" \
    --right "${input_files2[$i]}" \
    --output "$output_dir/$base_filename"

    # Calculate exN50 values using TrinityStats.pl
    TrinityStats.pl "$output_dir/$base_filename"/Trinity.fasta
done
#Look/read about docker and singularity, learn with cluster, go through illifu documentation, create batch script in illifu
