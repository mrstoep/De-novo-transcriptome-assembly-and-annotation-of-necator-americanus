process BUSCO {


    input:
    path input_file

    output:
    path "${output_file}/*"

    script:
    """
    mkdir -p ${output_file}

    singularity exec ${params.singularity_image2} busco \
        -i ${input_file} -o ${output_file} \
        -f -l nematoda_odb10 -m transcriptome
    """
}
