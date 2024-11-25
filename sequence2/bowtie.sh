#!/bin/bash

set -e
set -x

#set input and output file
input_file_data=./data
input_file_assembly=./output/trinity.Trinity.fasta
bowtie_index_prefix=./output/bowtie/index
output_file=./output/bowtie

#making sure ouput_dir is created

mkdir -p $bowtie_index_prefix
mkdir -p $output_file

#build bowtie index from the transcriptome assembly
singularity exec ./bowtie2_2.5.3.sif bowtie2-build $input_file_assembly $bowtie_index_prefix

#Aligning original sequences to the transcriptome assembly
 singularity exec ./bowtie2_2.5.3.sif bowtie2 -x $bowtie_index_prefix \
                          -1 $input_file_data/*1.fastq \
                          -2 $input_file_data/*2.fastq \
                          -S $output_file/alignment_output.sam \
                          



