process FASTQC {

    input:
    path(reads)

    output:
    path("*_fastqc.{zip,html}"), emit: fastqc_out 

    script:
    """
    singularity exec ${params.singularity_image4} fastqc ${reads}
    """
}

