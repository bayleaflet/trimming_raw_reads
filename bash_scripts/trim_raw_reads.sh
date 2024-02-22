{
usage="$(basename "$0") [-h] [-l <SRA_list>] [-d <working_directory>]
Script to perform raw read preprocessing using fastp
    -h show this help text
    -l path/file to tab-delimitted sra list
    -d working directory"
options=':h:l:d:'
while getopts $options option; do
    case "$option" in
        h) echo "$usage"; exit;;
	l) l=$OPTARG;;
	d) d=$OPTARG;;
	:) printf "missing argument for -%s\n" "$OPTARG" >&2; echo "$usage" >&2; exit 1;;
       \?) printf "illegal option: -%s\n" "$OPTARG" >&2; echo "$usage" >&2; exit 1;;
     esac
done

echo $l
echo $d

# mandatory arguments
if [ ! "$l" ] || [ ! "$d"]; then
    echo "arguments -l and -d must be provided"
    echo "$usage" >&2; exit 1
fi

begin=`date +%s`

echo "load required modules"
module load fastqc/0.11.4
module load multiqc/1.12
module load fastp/0.20.1

echo "create file storing environment"
#mkdir -p remix1/sra_files
#mkdir -p remix1/raw_reads
mkdir -p remix1/cleaned_reads/merged_reads
mkdir -p remix1/cleaned_reads/unmerged_reads
#
#echo "Downloading SRA files from the given list of accessions"
#module load sra-toolkit/3.0.2
#cd sra_files
#prefetch --max-size 800G -O ./ --option-file ../${l}
#ls | grep SRR > sra_list
#cd ..
#echo "SRA files were downloaded in current directory"
#echo ""
#
#echo "Getting fastq files from SRA files"
#cd sra_files
#while read i; do 
#	cd "$i" 
#	fastq-dump --split-files --gzip "$i".sra 
#	# the --split-files option is needed for PE data
#	mv "$i"*.fastq.gz ../../raw_reads/ 
#	cd ..
#done<sra_list
#cd ..
#module unload sra-toolkit/3.0.2
#echo "Done"
#
#
####################################
## Quality check of raw read files #
####################################
#
#echo "Perform quality check of raw read files"
#cd raw_reads
#ls
#pwd
#while read i; do 
#  	fastqc "$i"_1.fastq.gz # insert description here
#  	fastqc "$i"_2.fastq.gz # insert description here
#done<../sra_files/sra_list
#multiqc . # insert description here
#cd ..

####################################################
# Trimming downloaded Illumina datasets with fastp #
####################################################

echo "Trimming downloaded Illumina datasets with fastp."
cd raw_reads
pwd
ls *.fastq.gz | cut -d "." -f "1" | cut -d "_" -f "1" | sort | uniq > fastq_list
while read z ; do 
# Perform trimming
# -----------------------------------------------
# Insert description of -i and -I parameters here
# -i Indicates the infile for usage
# Insert description of -m, --merged_out, --out1, and --out2 parameters here
# --m is an on/off option that will merge paired-end reads that overlap into a single read
# --merged_out is the filename for storing merged reads
# --out1 and --out2 iare the filenames for unmerged reads that passed trim filters
# Insert description of -e and -q here
# -e indicates a quality number of which when matching e, the reads discarded
# -q Is the threshold for qualifying 'a' base, which naturally is at 15
# Insert description of -u and -l here
# -u reads with U% bases under q value are discarded, set at 40
# -l reads with length( after filtering) >l are discarded
# Insert description of --adapter_sequence and --adapter_sequence_r2 here
# --adapter_seq is the nucleotide sequence for the adatper used for sequencing
# --adaptor_seq_2 is the second adapter for read 2 in paired-end sequencing
# Insert description of -M, -W, -5, and -3 here
# -M is the cut mean quality, which is the min. avg. in a sliding window to not remove bases
# -W is the cut_window_size, the number of bases in a sliding window, automatically set at 4
# -5 indicates the 5' cut front, uses sliding window to trim leading seq qith avgs <M. Is naturally off
# -3 is the 3' cut front, and uses sliding window to trim trailing sequences with averages <M. Is normally off
# Insert description of -c here
# -c Is the correction, or overlap analysis to correct bases with low reads (only for PE reads)
# -----------------------------------------------
fastp -i "$z"_1.fastq.gz -I "$z"_2.fastq.gz \
      -m --merged_out ${d}/cleaned_reads/merged_reads/"$z"_merged.fastq \
      --out1 ${d}/cleaned_reads/unmerged_reads/"$z"_unmerged1.fastq --out2 ${d}/cleaned_reads/unmerged_reads/"$z"_unmerged2.fastq \
      -e 25 -q 15 \
      -u 30 -l 15 \
      --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
      --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
      -M 20 -W 4 -5 -3 \
      -c 
cd ../cleaned_reads/merged_reads
gzip "$z"_merged.fastq
cd ../../raw_reads
done<fastq_list
cd ..
echo ""



#######################################
# Quality check of cleaned read files #
#######################################

echo "Perform check of cleaned read files"
cd ${d}/cleaned_reads/merged_reads
pwd
while read i; do 
	fastqc "$i"_merged.fastq.gz # insert description here
done<${d}/sra_files/sra_list

 }
