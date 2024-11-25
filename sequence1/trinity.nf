process TRINITY {

    publishDir "${params.outdir}/trinity", mode: 'copy'
    input:
    tuple val(sample), path(fq1), path(fq2)

    output:
    path("trinity.Trinity.fasta"), emit: trinity_output
    //path("*.fasta"), emit: trinity_output

    script:
    """
    mkdir -p ${params.outdir}/trinity

    singularity exec ${params.singularity_image1} Trinity \
        --seqType fq \
        --SS_lib_type FR \
        --max_memory 2G \
        --CPU 2 \
        --left ${fq1} \
        --right ${fq2} \
        --output "${params.outdir}/trinity"
    """
}
