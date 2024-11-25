process EXN50 {


    input:
    path input_file
    
    script:
    """
    TrinityStats=/usr/local/bin/util/TrinityStats.pl

    //added words like 
    singularity exec ${params.singularity_image1} $TrinityStats perl $input_file1 --salmon $input_file2
    """
}
