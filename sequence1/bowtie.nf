process BOWTIE {


    input:
    path input_file_data
    path input_file_assembly
    path bowtie_index_prefix

    output:
    path "${output_file}/*"

    script:
    """
    mkdir -p ${output_file}
    mkdir -p ${bowtie_index_prefix}

    #Building index files
    singularity exec ${params.singularity_image3} bowtie2-build ${input_file_assembly} ${bowtie_index_prefix}

    #Running alignment
    singularity exec ${params.singularity_image3} bowtie2 \
        -x ${bowtie_index_prefix} \
        -1 ${input_file_data}/*1.fastq \
        -2 ${input_file_data}/*2.fastq \
        -S ${output_file}/alignment_output.sam
    """
}
