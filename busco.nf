process BUSCO {


    input:
    path(transcriptome)

    output:
    path "${output_file}/*"
    path "busco.txt"

    script:
    """
    mkdir -p ${params.outdir}/busco

    singularity exec ${params.singularity_image2} busco \
        -i ${transcriptome} -o "${params.outdir}/busco" \
        -f -l nematoda_odb10 -m transcriptome > busco.txt
    """
}
