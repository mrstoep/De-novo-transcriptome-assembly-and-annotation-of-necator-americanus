process MMSEQS {


    input:
    path input_file

    output:
    path "${output_dir}/*"

    script:
    """
    mkdir -p ${output_file}

    #Creating mmseqs database
    singularity exec ${params.singularity_image6} mmseqs \
        createdb ${input_file} ${output_dir}/assembly_db
   
    #Clustering the sequences
    singularity exec ${params.singularity_image6} mmseqs \
        linclust ${output_dir}/assembly_db ${output_dir}/clustered_db tmp_dir --min-seq-id 0.95 -c 0.9

    #Extracting representative sequences
    singularity exec ${params.singularity_image6} mmseqs \
        result2repseq ${output_dir}/assembly_db ${output_dir}/representative_db

    #convertating representative_db into FASTA format
    singularity exec ${params.singularity_image6} mmseqs \
        result2flat ${output_dir}/assembly_db ${output_dir}/thinned_assembly.fasta
    """
}
