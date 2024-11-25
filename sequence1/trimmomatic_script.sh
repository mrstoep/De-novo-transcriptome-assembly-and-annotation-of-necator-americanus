#!/bin/bash

# Setting the loop to exit if there is an error
# Setting each command to show as it is executed
set -e
set -x

# Defining directories and making output directory
input_dir=./data
output_dir=./output/trimmomatic

mkdir -p "$output_dir"

# Initializing variables for paired reads
R1=""
R2=""

# Assigning the variables R1 and R2 to the base names
for file in "$input_dir"/*.fastq; do
  base=$(basename "$file" ".fastq")
  if [[ "$file" =~ _1.fastq$ ]]; then
    R1="$base"
  elif [[ "$file" =~ _2.fastq$ ]]; then
    R2="$base"
  fi
done

# Ensuring both R1 and R2 variables are set
if [[ -z "$R1" || -z "$R2" ]]; then
  echo "Paired files not found or not correctly named."
  exit 1
fi

# Assigning variables for input and output sequences
inR1="$input_dir/$R1.fastq"
inR2="$input_dir/$R2.fastq"

R1P="$output_dir/trimmed_${R1}_P.fastq.gz"
R1U="$output_dir/trimmed_${R1}_U.fastq.gz"
R2P="$output_dir/trimmed_${R2}_P.fastq.gz"
R2U="$output_dir/trimmed_${R2}_U.fastq.gz"

# Running Trimmomatic with specified options
trimmomatic PE -threads 4 -phred33 "$inR1" "$inR2" "$R1P" "$R1U" "$R2P" "$R2U" SLIDINGWINDOW:4:15 MINLEN:36

