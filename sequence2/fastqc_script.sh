#!/bin/bash

set -x
set -e

#set variables for locating output and input data
input_dir=./data
output_dir=./output/fastqc
singularity_image=/users/tstoep/project/test/fastqc.sif

#Run fastqc on both sequences
for i in {1..2}
  do
    echo "FastQC is processing *$i.fastq"
    singularity exec ${singularity_image} fastqc --extract -o $output_dir $input_dir/*$i.fastq
done

