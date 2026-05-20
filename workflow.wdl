import "./tasks/Core.wdl" as Core

workflow {{ project_name }} {

    String  sample_id

    File    INPUT_FILE_PATH
    File    DATABASE_PATH

    String  ADAPTER_SEQ
    Int     RANDOM_BARCODE_LENGTH
    Int     QFILTER_MIN_QUAL
    Int     QFILTER_MIN_READ_FRAC
    Int     MIN_READ_LENGTH

    String  KEEP_RANDOM_BARCODE_STATS
    
    String  MAIN_ORGANISM_GENOME_ID
    
    String  STAR_alignEndsType
    Int     STAR_outFilterMatchNmin
    Float   STAR_outFilterMatchNminOverLread
    Int     STAR_outFilterMismatchNmax

    String  ENDOGENOUS_LIB_PRIORITY
    
    String  JAVA_RAM
    
    String docker
	String cluster_config
	String disk_size

    call Core.Core as Core {
        input:
            sample_id=sample_id,
            INPUT_FILE_PATH=INPUT_FILE_PATH, DATABASE_PATH=DATABASE_PATH,
            ADAPTER_SEQ=ADAPTER_SEQ, RANDOM_BARCODE_LENGTH=RANDOM_BARCODE_LENGTH, QFILTER_MIN_QUAL=QFILTER_MIN_QUAL, QFILTER_MIN_READ_FRAC=QFILTER_MIN_READ_FRAC, MIN_READ_LENGTH=MIN_READ_LENGTH,
            KEEP_RANDOM_BARCODE_STATS=KEEP_RANDOM_BARCODE_STATS, MAIN_ORGANISM_GENOME_ID=MAIN_ORGANISM_GENOME_ID,
            STAR_alignEndsType=STAR_alignEndsType, STAR_outFilterMatchNmin=STAR_outFilterMatchNmin, STAR_outFilterMatchNminOverLread=STAR_outFilterMatchNminOverLread, STAR_outFilterMismatchNmax=STAR_outFilterMismatchNmax,
            ENDOGENOUS_LIB_PRIORITY=ENDOGENOUS_LIB_PRIORITY,
            JAVA_RAM=JAVA_RAM,
            docker=docker, cluster_config=cluster_config, disk_size=disk_size
 
    }


}
