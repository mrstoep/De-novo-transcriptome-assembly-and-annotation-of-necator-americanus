process BOWTIE {


    input:
    path(transcriptome)
    tuple val(sample), path(reads)

    output:
    path "${output_file}/*"
    path "bowtie.txt"

    script:
    """
    #Making directories
    mkdir -p ${params.outdir}
    mkdir -p ${params.outdir}/bowtie
    mkdir -p ${params.outdir}/bowtie/index

    #Building index files
    singularity exec ${params.singularity_image3} bowtie2-build ${transcriptome} ${params.outdir}/bowtie/index

    #Running alignment
    singularity exec ${params.singularity_image3} bowtie2 \
        -x "${params.outdir}/bowtie/index" \
        -1 ${reads[0]} \
        -2 ${reads[1]} \
        -S ${params.outdir}/bowtie/alignment_output.sam > bowtie.txt
    """
}
