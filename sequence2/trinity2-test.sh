#!/bin/bash

# Exit if there is an error in the loop
# Display each command before it is executed
set -e
set -x

# Define directories and make output directory
input_dir=./output/trimmomatic
output_dir=./output/trinity   # This should contain the word 'trinity'
singularity_image=trinityrnaseq_latest.sif

# Ensure the output directory contains the word 'trinity'
if [[ "$output_dir" != *trinity* ]]; then
  echo "Error: output directory must contain the word 'trinity' as a safety precaution."
  exit 1
fi

mkdir -p $output_dir

# Pull the Docker image and convert to Singularity image if not already done
#if [ ! -f "$singularity_image" ]; then
 #   singularity pull docker://trinityrnaseq/trinityrnaseq
#fi

# Get list of input files
input_files1=("$input_dir"/*_1_P.fastq.gz)
input_files2=("$input_dir"/*_2_P.fastq.gz)

# Extract the base filename without extension
#base_filename=$(basename "${input_files1[$i]}" _1_P.fastq.gz)

# Execute Trinity
singularity exec $singularity_image Trinity \
        --seqType fq \
        --SS_lib_type FR \
        --max_memory 2G \
        --CPU 2 \
        --left "${input_files1[$i]}" \
        --right "${input_files2[$i]}" \
        --output "$output_dir"
