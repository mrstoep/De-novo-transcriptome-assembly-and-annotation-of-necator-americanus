process TRINITY {

 
    input:
    tuple val(sample), path(reads)

    output:
    path("trinity.Trinity.fasta"), emit: assembly
    path("$params.outdir}/trinity/salmon_outdir/quant.sf"), emit: quant

    script:
    """
    mkdir -p ${params.outdir}/trinity

    singularity exec ${params.singularity_image1} Trinity \
        --seqType fq \
        --SS_lib_type FR \
        --max_memory 2G \
        --CPU 2 \
        --left ${reads[0]} \
        --right ${reads[1]} \
        --output "${params.outdir}/trinity"
    """
}
