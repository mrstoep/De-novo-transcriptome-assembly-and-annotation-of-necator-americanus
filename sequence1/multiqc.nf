process multiqc {
    publishDir("${params.outdir}/multiqc/", mode: 'copy', overwrite: true)
    //label 'medium'

    input:
    path (inputfiles)

    output:
    path "multiqc_report.html"

    script:
    """
    singularity exec ${params.singularity_image5} multiqc .
    """
}
