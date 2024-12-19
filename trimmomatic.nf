process TRIMMOMATIC {
    

    input:
    tuple val(sample), path(reads)

    output:
    tuple val("${sample}"), path("*_P.fastq.gz"), emit: trimmed_reads

    script:
    """
    singularity exec ${params.singularity_image5} trimmomatic \
        PE -threads 4 -phred33 ${reads[0]} ${reads[1]} \
        ${sample}_1_P.fastq.gz \
        ${sample}_1_U.fastq.gz \
        ${sample}_2_P.fastq.gz \
        ${sample}_2_U.fastq.gz \
        SLIDINGWINDOW:4:15 MINLEN:36
    """
}
