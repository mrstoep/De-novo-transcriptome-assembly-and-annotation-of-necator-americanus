#!/bin/bash

set -x
set -e

# Define paths
sam_file="./output/bowtie/alignment_output.sam"
bam_file="./output/bowtie/alignment_output.bam"
sorted_bam_file="./output/bowtie/alignment_output_sorted.bam"
coverage_file="./output/bowtie/coverage_output.txt"
coverage_histogram_file="./output/bowtie/coverage_histogram.txt"
histogram_plot="./output/bowtie/coverage_histogram.png"

# Step 1: Convert SAM to BAM
samtools view -bS $sam_file > $bam_file

# Step 2: Sort BAM file
samtools sort -o $sorted_bam_file $bam_file

# Step 3: Calculate coverage
samtools depth $sorted_bam_file > $coverage_file

# Step 4: Calculate summary statistics

# Average coverage
avg_coverage=$(awk '{sum+=$3; count++} END {print sum/count}' $coverage_file)
echo "Average Coverage: $avg_coverage"

# Median coverage
median_coverage=$(awk '{a[NR]=$3} END {if (NR%2) {print a[int(NR/2)+1]} else {print (a[NR/2]+a[NR/2+1])/2}}' $coverage_file)
echo "Median Coverage: $median_coverage"

# Maximum coverage
max_coverage=$(awk '{if($3>max) max=$3} END {print max}' $coverage_file)
echo "Maximum Coverage: $max_coverage"

# Minimum coverage
min_coverage=$(awk '{if(min=="") min=$3; if($3<min) min=$3} END {print min}' $coverage_file)
echo "Minimum Coverage: $min_coverage"

# Total number of positions
total_positions=$(wc -l < $coverage_file)
echo "Total Positions: $total_positions"

# Total sum of all coverages
total_coverage=$(awk '{sum+=$3} END {print sum}' $coverage_file)
echo "Total Coverage: $total_coverage"

# Step 5: Generate histogram data file
awk '{print $3}' $coverage_file | sort -n | uniq -c > $coverage_histogram_file

# Create a Gnuplot script
gnuplot_script=$(cat <<EOF
set terminal png size 800,600
set output '$histogram_plot'
set title 'Coverage Depth Histogram'
set xlabel 'Coverage Depth'
set ylabel 'Frequency'
set style data histograms
set style fill solid
plot '$coverage_histogram_file' using 2:1 with boxes
EOF
)

# Save Gnuplot script to a file
echo "$gnuplot_script" > ./output/bowtie/coverage_histogram.gp

# Generate the plot
gnuplot ./output/bowtie/coverage_histogram.gp
