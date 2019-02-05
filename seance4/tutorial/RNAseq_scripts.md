# Mise en pratique : exemple de scripts pour l'analyse de données RNAseq en utilisant les ressources du cluster NNCR  

## Connnection au cluster NNCR IFB et chargement des environnements nécessaires

```bash
$ ssh <username>@core.cluster.france-bioinformatique.fr
```

```bash
module load conda
source activate eba_rnaseq_ref-2018
```

## Le jeu de données

On dispose de 2 échantillons de reads pairés de *E. coli* : WT (Wild Type) et dFNR (mutant du gène FNR).  
Il y a 2 répliques par échantillons (soient 4 échantillons et 8 fichiers, les paires de reads étant stockées dans 2 fichiers séparés) :

```bash
$ ls  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/*.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR1_1.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR1_2.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR2_1.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR2_2.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT1_1.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT1_2.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT2_1.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT2_2.fastq
```

## Première exemple : contrôle qualité

Nous allons utiliser un premier script bash pour lancer sur le cluster de l'IFB 8 calculs `fastqc` correspondant aux 8 fichiers à analyser :  

```bash
$ cat fastqc_myfiles.sh  
#! /bin/bash  
data=$(ls $1/*.fastq)   
for fastqc_file in ${data[@]} 
do  
      echo "srun srun fastqc --quiet  ${fastqc_file} -o ./fastqc-results/ 2>> fastqc.err "
      srun fastqc --quiet  ${fastqc_file} -o ./fastqc-results/ 2>> fastqc.err  & 
done  
```

Pour lancer ce script on utilise la commande suivante :

```bash  
    ./fastqc_myfiles.sh /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq
```

**Questions** :   
- Combien de jobs sont lancés sur le cluster ?  
- Comment suivre l'éxécution des jobs ?  
- Où seront produits les fichiers résulats de la commande `fastqc`?  
- Que veut dire "2>> fastqc.err" ?  

**Solution alternative :** il est possible de paralléliser l'exécution des 8 jobs en utilisant l'option `--array`
Ceci est possible lorsqu'on effectue exactement le même traitement sur un ensemble de fichiers
Dans ce cas on doit préciser le nombre de jobs maximum qui vont être lancés
C'est à priori la solution de parallélisation la plus efficace

Tester le lancement du script suivant comme suit pour paralléliser le lancement des 8 jobs en parallèle :

```bash 
cat ./fastqc_myfiles_array.sbatch
#! /bin/bash
#SBATCH --array=0-20

DATA=(/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/*.fastq)
srun fastqc --quiet ${DATA[$SLURM_ARRAY_TASK_ID]} -o ./fastqc-results/ 2>> fastqc.err
```

Puis lancer l'execution comme suit :
```bash 
$ sbatch --array=0-20 ./fastqc_myfiles_array.sbatch
```

**Question** :
- Que constatez-vous en terme de performance ?
- Que pensez-cous qu'il se passe s'il y a plus de 20 fichiers `.fastq` à traiter ?


## Deuxième exemple : mapping des reads sur le génome de E. coli

Nous allons utiliser le logiciel **STAR** pour aligner les reads RNAseq sur le génome de E. coli.  

Pour pouvoir utiliser STAR il faut d'abord indexer le génome de référence.  

Regarder la documentation de STAR  
```bash  
$ STAR --help | less
```

L'usage est :  
 `Usage: STAR  [options]... --genomeDir REFERENCE   --readFilesIn R1.fq R2.fq`  

Nous allons commencer par créer un répertoire pour le génome de référence indexé :  
```bash  
mkdir ./Ecoli_star
```

Puis nous lancons la commande d'indexation du génome sur le cluster :  

```bash  
srun STAR --runMode genomeGenerate --genomeDir ./Ecoli_star --genomeFastaFiles /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/genome/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.dna.chromosome.Chromosome.fa  --runThreadN 4 --sjdbGTFfile /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/genome/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.gtf
```

Une fois l'index créé, nous allons créer un script permettant de lancer un mapping STAR avec la commande `sbatch`pour une paire de fichiers fastq (reads 1 et reads 2) donnés en arguments :

```bash
$ cat star_myfiles.sbatch 
#!/bin/bash
#star_myfiles.sbatch
#SBATCH -c 28 # 28 CPUs per task (and node)
#SBATCH -N 1 # on one node
#SBATCH -t 0-4:00 # Running time of 4 hours
#SBATCH --mem 16G # Memory request 16Gb
raw_readsR1=$1
raw_readsR2=$2
star_outfile="$(basename $raw_readsR1 _1.fastq)-star-out"
STAR --runThreadN 56 --outSAMtype BAM SortedByCoordinate --readFilesIn ${raw_readsR1} ${raw_readsR2} --genomeDir /shared/home/hchiapello/DUBii/module1/Ecoli_star/ --outFileNamePrefix ${star_outfile}
```

Ce script sera ensuite lancé grâce à un 2ème script qui parcourera les fichiers fastq au format `*_1.fastq` du répertoire où sont stockées les données :  

```bash
$ cat star_paired_data.sh
#!/bin/bash
REP_FASTQ_FILES=$1
R1_fastq_files=$(ls $1/*_1.fastq)

for fastq_file in ${R1_fastq_files[@]}
do 
       sample_file="$(basename $fastq_file _1.fastq)"   
       path_fastq="$(dirname $fastq_file)"  
       #echo $sample_file  
       sbatch -o ${sample_file}.stdout.txt -e ${sample_file}.stderr.txt star_myfiles.sbatch ${path_fastq}/${sample_file}_1.fastq ${path_fastq}/${sample_file}_2.fastq  
       sleep 1 # pause to be kind to the scheduler  
done  
```

Pour lancer ce script on utilise la commande suivante :

```bash  
    ./star_paired_data.sh /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq
```
**Questions** :   
- Combien de jobs sont lancés sur le cluster ?    
- Combien de noeud et de CPU seront utilisés pour chaque job ?  
- A combien de temps de calcul maximal a-t-on estimé chaque job ?  
