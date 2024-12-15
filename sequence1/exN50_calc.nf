process EXN50 {

    
    input:
    path(transcriptome)
    path(quant_file)
     
    
    //output:
    //path(exN50.txt)

    script:
    """
    singularity exec ${params.singularity_image1} ${params.trinity_stats} $transcriptome --salmon $quant_file > exN50.txt
    """
}
