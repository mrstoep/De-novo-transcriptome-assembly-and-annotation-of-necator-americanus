#!/bin/bash

#SBATCH --job-name=assembly_blastx_annotation  # Job name
#SBATCH --output=blastx_annotation.out  # Standard output and error log
#SBATCH --error=blastx_annotation.err  # Error log
#SBATCH --time=02:00:00  # Time limit (hh:mm:ss)
#SBATCH --nodes=1  # Number of nodes
#SBATCH --ntasks-per-node=1  # Number of tasks per node
#SBATCH --cpus-per-task=4  # Number of CPU cores per task (adjust based on available resources)
#SBATCH --mem=16G  # Memory per node (adjust based on job requirements)

set -e
set -x

#Load blast from conda
#module load anaconda3
#conda activate hprj2
#module load blast+/2.13.0

#define input and output files
input_dir=/users/tstoep/project/test/output/mmseqs
output_dir=/users/tstoep/project/test/output/annotation

mkdir -p $output_dir

#Downloading SwissProt database
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
gunzip uniprot_sprot.fasta.gz

#Creating diamond database
diamond makedb --in uniprot_sprot.fasta -d swissprot

#running blast X for functional anotation
diamond blastx --query $input_dir/thinned_assembly.fasta \
       --db swissprot.dmnd \
       --out $output_dir/diamond_annotation.tsv \
       --evalue 1e-5 \
       --outfmt 6 qseqid sseqid pident length mismatch gapopen qend sstart send evalue bitscore stitle \
       --max-target-seqs 1 \
       --threads 8
