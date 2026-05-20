task Core {
    String  sample_id

    File    INPUT_FILE_PATH
    File    DATABASE_PATH

    String  ADAPTER_SEQ
    String  RANDOM_BARCODE_LENGTH
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
    String INPUT_FILE_ID = if basename("${INPUT_FILE_PATH}", ".gz") != basename("${INPUT_FILE_PATH}") then basename("${INPUT_FILE_PATH}", ".gz") else basename(basename("${INPUT_FILE_PATH}", ".fastq"), ".sra")

    command <<<

        #set -o pipefail
        #set -e
        nt=$(nproc)

        mkdir ${sample_id}

        
        if [ "${ADAPTER_SEQ}" = "not_available" ]
        then
            PARAMETERS_ADAPTER=""
        else
            PARAMETERS_ADAPTER=$(echo '-A ${ADAPTER_SEQ}')
        fi

        exceRpt \
            -d ${DATABASE_PATH} \
            -N $nt \
            $PARAMETERS_ADAPTER -l ${RANDOM_BARCODE_LENGTH} -m ${MIN_READ_LENGTH} \
            -Q ${QFILTER_MIN_QUAL} -F ${QFILTER_MIN_READ_FRAC} \
            -M ${MAIN_ORGANISM_GENOME_ID} \
            -S ${STAR_alignEndsType} -O ${STAR_outFilterMatchNmin} -f ${STAR_outFilterMatchNminOverLread} -T ${STAR_outFilterMismatchNmax} \
            -E ${ENDOGENOUS_LIB_PRIORITY} \
            -K ${KEEP_RANDOM_BARCODE_STATS} \
            -J ${JAVA_RAM} \
            -i ${INPUT_FILE_PATH} \
            -o ${sample_id} \
            -s ${sample_id}
        
        find . -depth > fileList.txt

    >>>

    runtime {
	docker: docker
	instanceTypes: [cluster_config]
	systemDisk: "cloud " + disk_size
    }

    output {
	File fileList = "fileList.txt"
	Array[File] files_stat = glob("${sample_id}/*")
	Array[File] files_core = glob("${sample_id}/${INPUT_FILE_ID}_${sample_id}/*")
    }
}
