#!/bin/bash

# Exit on error
set -e

# Step 1: Define Variables
TSV_FILE="diamond_annotation.tsv"  # Input TSV file
SUMMARY_FILE="annotation_summary.txt"  # Output summary file

# Step 2: Check if TSV file exists
if [ ! -f "$TSV_FILE" ]; then
    echo "Error: Input TSV file '$TSV_FILE' not found!"
    exit 1
fi

# Step 3: Generate Summary
echo "Summarizing results from $TSV_FILE..."

# Count total number of queries
TOTAL_QUERIES=$(cut -f1 "$TSV_FILE" | sort | uniq | wc -l)

# Count unique proteins matched (subject IDs)
UNIQUE_PROTEINS=$(cut -f2 "$TSV_FILE" | sort | uniq | wc -l)

# Find the most common annotations (subject descriptions)
COMMON_ANNOTATIONS=$(cut -f13 "$TSV_FILE" | sort | uniq -c | sort -nr | head -10)

# Write the summary to a file
echo "Annotation Summary:" > "$SUMMARY_FILE"
echo "-------------------" >> "$SUMMARY_FILE"
echo "Total queries: $TOTAL_QUERIES" >> "$SUMMARY_FILE"
echo "Unique proteins matched: $UNIQUE_PROTEINS" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"
echo "Top 10 most common annotations:" >> "$SUMMARY_FILE"
echo "$COMMON_ANNOTATIONS" >> "$SUMMARY_FILE"

# Step 4: Completion Message
echo "Summary written to $SUMMARY_FILE."
