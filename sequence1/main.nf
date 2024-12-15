#!/usr/bin/env nextflow 

//include { FASTQC } from './fastqc.nf'
//include { TRIMMOMATIC } from './trimmomatic.nf'
//include { TRINITY } from './trinity.nf'
//include { EXN50 } from './exN50_calc.nf'
//include { BUSCO } from './busco.nf'
//include { BOWTIE } from './bowtie.nf'
//include { MMSEQS } from './mmseqs.nf'
include { DIAMOND } from './annotation.nf'

//steps 1 to 3
unpaired_reads = Channel.fromPath(params.reads, checkIfExists:true)
paired_reads = Channel.fromFilePairs(params.reads, checkIfExists:true)

//Steps 4
transcriptome = Channel.fromPath(params.transcriptome, checkIfExists:true)
quant_file = Channel.fromPath(params.quant_file, checkIfExists:true)

//step 8
thinned_assembly = Channel.fromPath(params.thinned_assembly)
diamond_db = Channel.fromPath(params.diamond_db)

workflow {
    //FASTQC
    //FASTQC(unpaired_reads)

    //TRIMMOMATIC
    //TRIMMOMATIC(paired_reads)

    //TRINITY
    //TRINITY(TRIMMOMATIC.out.trimmed_reads)

    //EXN50_calc
    //EXN50(transcriptome, quant_file)
    
    //BUSCO
    //BUSCO(transcriptome)

    //BOWTIE
    //BOWTIE(transcriptome, paired_reads)

    //MMSEQS
    MMSEQS(transcriptome)

    //DIAMOND
    DIAMOND(thinned_assembly, diamond_db)
}
