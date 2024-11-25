#!/usr/bin/env nextflow 

include { FASTQC as rawfastqc; FASTQC as trimfastqc } from './fastqc3.nf'
include { TRIMMOMATIC } from './trimmomatic3.nf'
//include { multiqc } from "./multiqc3.nf"
include { TRINITY } from './trinity3.nf'
//include { EXN50 } from './exN50_3.nf'

read_pairs_ch = Channel
        .fromFilePairs(params.reads, checkIfExists:true)

workflow {
    //QC on raw reads
    rawfastqc(read_pairs_ch)


    //TRIMMOMATIC step
    TRIMMOMATIC(read_pairs_ch)
    trimfastqc(TRIMMOMATIC.out.paired_fastq)
    
    //multiqc_input = rawfastqc.out.fastqc_out
     //.mix(trimfastqc.out.fastqc_out)
     //.collect()
    //TRINITY(multiqc_input) 

    //Trinity step
    trinity_input = TRIMMOMATIC.out.paired_fastq
    TRINITY(trinity_input)   

    /* EXN50 step
    transcriptome = Channel.fromPath(params.transcriptome, checkIfExists:true)
    quant_file = Channel.fromPath(params.quant_file, checkIfExists:true)
    trinity_stats = Channel.fromPath(params.trinity_stats, checkIfExists:true)

    EXN50(transcriptome, quant_file, trinity_stats) */
}
