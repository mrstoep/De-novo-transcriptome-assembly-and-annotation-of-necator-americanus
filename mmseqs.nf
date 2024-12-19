process MMSEQS {


    input:
    path(transcriptome)

    output:
    path("${output_dir}/mmseqs/thinned_assembly.fasta"), emit: thinned_assembly

    script:
    """
    mkdir -p ${params.outdir}/mmseqs

    #Creating mmseqs database
    singularity exec ${params.singularity_image6} mmseqs \
    createdb ${transcriptome} ${params.outdir}/mmseqs/assembly_db
   
    #Clustering the sequences
    singularity exec ${params.singularity_image6} mmseqs \
    linclust ${params.outdir}/mmseqs/assembly_db ${params.outdir}/mmseqs/clustered_db tmp_dir --min-seq-id 0.95 -c 0.9

    #Extracting representative sequences
    singularity exec ${params.singularity_image6} mmseqs \
    result2repseq ${params.outdir}/mmseqs/assembly_db ${params.outdir}/mmseqs/representative_db

    #convertating representative_db into FASTA format
    singularity exec ${params.singularity_image6} mmseqs \
    result2flat ${params.outdir}/assembly_db ${params.outdir}/mmseqs/thinned_assembly.fasta
    """
}
