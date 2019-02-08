#! /bin/bash 

bam_files=$(ls $1/*.bam) 

for name in ${bam_files}
do
	samtools sort ${name} ${name}-sorted
done
