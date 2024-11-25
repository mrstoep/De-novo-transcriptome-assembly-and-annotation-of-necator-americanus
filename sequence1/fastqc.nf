process FASTQC {
    //publishDir "${params.outdir}/raw_fastqc/", mode: 'copy', overwrite: true
    label 'medium'

    input:
    tuple val(sample), path(reads)

    output:
    path("*_fastqc.{zip,html}"), emit: fastqc_out // output files produced by fastqc

    script:
    """
    singularity exec ${params.singularity_image4} fastqc ${reads}
    """
}

