#!/bin/bash

set -e
set -x

#set input and output file
input_file_data=./data
input_file_assembly=./output/mmseqs/thinned_assembly.fasta
bowtie_index_prefix=./output/bowtie_thinned_assembly/index
output_file=./output/bowtie_thinned_assembly

#making sure ouput_dir is created

mkdir -p $output_file
mkdir -p $bowtie_index_prefix

#build bowtie index from the transcriptome assembly
singularity exec ./bowtie2_2.5.3.sif bowtie2-build $input_file_assembly $bowtie_index_prefix

#Aligning original sequences to the transcriptome assembly
 singularity exec ./bowtie2_2.5.3.sif bowtie2 -x $bowtie_index_prefix \
                          -1 $input_file_data/*1.fastq \
                          -2 $input_file_data/*2.fastq \
                          -S $output_file/thinned_assembly_alignment_output.sam \
