# Mise en pratique : exemple de scripts pour l'analyse de données NGS en utilisant les ressources du cluster NNCR  

## Connnection au cluster NNCR IFB

```bash
$ ssh <username>@core.cluster.france-bioinformatique.fr
```

<!-- Chargement des environnements nécessaires -->
<!-- ```bash ! -->
<!-- $ module load eba_rnaseq_ref/2018 -->
<!-- ``` -->

## Le jeu de données

On dispose de 2 échantillons de reads pairés de *E. coli* : WT (Wild Type) et dFNR (mutant du gène FNR).  
Il y a 2 répliques par échantillons (soient 4 échantillons et 8 fichiers, les paires de reads étant stockées dans 2 fichiers séparés) :

```bash
$ ls  /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/*.fastq/*.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR1_1.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR1_2.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR2_1.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR2_2.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT1_1.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT1_2.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT2_1.fastq
/shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT2_2.fastq
```

## Exercice 1 : 3 versions de scripts bash pour faire du contrôle qualité 

1.1 Ecrire 3 scripts bash pour lancer sur le cluster de l'IFB 8 calculs `fastqc` correspondant aux 8 fichiers fastq à analyser.  
- Un premier script basique qui n'utilise pas la parallélisation mais lance séquenciellement le traitement sur les 8 fichiers
- Un deuxième script qui utilise la version multi-threadée de fastqc sur 16 threads et qui lance séquenciellement le traitement des fichiers 
- Un troisième script qui utilise la version multi-threadée de fastqc sur 16 threads et qui lance en parallèle les 8 jobs

> **Réponse script v1 (aucune parallélisation) :**:
> > ```bash
> > $ cat fastqc_v1.sh  
> > #! /bin/bash  
> > module load fastqc/0.11.8 
> >
> > data=$(ls $1/*.fastq)  
> > for fastqc_file in ${data[@]}
> > do 
> >      srun fastqc --quiet  ${fastqc_file} -o ./fastqc-results/ 2>> fastqc.err  &
> > done
> > wait
>>```
{:.answer}

> **Réponse script v2 (version multithreadée de fastqc avec 16 threads):**:
> > ```bash
> > $ cat fastqc_v2.sh  
> > #! /bin/bash  
> > $SBATCH --cpus-per-task 16
> > module load fastqc/0.11.8
> >
> > data=$(ls $1/*.fastq)  
> > for fastqc_file in ${data[@]}
> > do 
> >      srun fastqc -t 16 --quiet  ${fastqc_file} -o ./fastqc-results/ 2>> fastqc.err  &
> > done
> > wait
>>```
{:.answer}

> **Réponse script v3 (version multithreadée de fastqc avec 16 threads avec execution des 8 jobs en parallème):**:
> > ```bash 
> > $ cat ./fastqc_v3.sh
> > #! /bin/bash
> > #SBATCH --array=0-7
> > $SBATCH --cpus-per-task 16
> > module load fastqc/0.11.8
> >
> >FASTQ_FILES=$(ls $1/*.fastq)
> >srun fastqc -t 16 --quiet ${FASTQ_FILES[$SLURM_ARRAY_TASK_ID]} -o ./fastqc-results/ 2>> fastqc.err
> >```
{:.answer}

> > Pour lancer ces scripts on utilise la commande suivante :
> > ```bash  
> > $ sbatch ./fastqc_myfiles.sh /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/*.fastq
> > 
> > ```
{:.answer}



**Questions** :   
- Indiquer le temps CPU obtenus pour les 3 scripts 
- Où seront produits les fichiers résulats de la commande `fastqc`?  
- Comment peut-on rediriger les fichiers d'eerreurs de la commande fasqc ? `2>> fastqc.err` ?  

**Solution alternative :** il est possible de paralléliser l'exécution des 8 jobs en utilisant l'option `--array`
Ceci est possible lorsqu'on effectue exactement le même traitement sur un ensemble de fichiers.
Dans ce cas on doit préciser le nombre de jobs maximum qui vont être lancés.
C'est à priori la solution de parallélisation la plus efficace en terme de temps de calcul.

Tester le lancement du script suivant comme suit pour paralléliser le lancement des 8 jobs en parallèle :



Pour regarder les ressources allouées à un job, on peut utiliser la commande 
```bash 
$ sacct --format=JobID,JobName,User,ReqCPUS,ReqMem,NTasks,MaxVMSize,MaxRSS,Start,End,NNodes,NodeList%40,CPUTime -j <id-du-job>
```

**Questions** :
- Que constatez-vous en terme de performance ?
- Que pensez-vous qu'il se passe s'il y a plus de 8 fichiers `.fastq` à traiter ?


##Exercice 2: mapping des reads sur le génome de *E. coli*

Nous allons utiliser le logiciel **STAR** pour aligner les reads RNAseq sur le génome de *E. coli*.  

Pour pouvoir utiliser STAR il faut d'abord indexer le génome de référence.  

Regarder la documentation de STAR  
```bash  
$ STAR --help | less
```

L'usage est :  
 `Usage: STAR  [options]... --genomeDir REFERENCE   --readFilesIn R1.fq R2.fq`  

Nous allons commencer par créer un répertoire pour le génome de référence indexé :  
```bash  
$ mkdir ./Ecoli_star
```

Puis nous lancons la commande d'indexation du génome sur le cluster :  

```bash  
$ srun STAR --runMode genomeGenerate --genomeDir ./Ecoli_star --genomeFastaFiles /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/genome/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.dna.chromosome.Chromosome.fa  --runThreadN 4 --sjdbGTFfile /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/genome/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.gtf
```

Une fois l'index créé, nous allons utiliser un script `star_pairedfiles.sbatch` permettant de lancer un mapping STAR sur toutes les paires de fichiers fatsq d'un répertoire donné en argument :

```bash
$ cat star_pairedfiles.sbatch
#!/bin/bash
#SBATCH -n 4
#SBATCH --cpus-per-task=24
#SBATCH --mem=64GB # Memory request 64Gb for the 4 tasks
#SBATCH --mem-per-cpu=16GB # Memory request 16Gb for each task
 
REP_FASTQ_FILES=$1
R1_fastq_files=$(ls $1/*_1.fastq)
 
for fastq_file in ${R1_fastq_files[@]}
do
       sample_file="$(basename $fastq_file _1.fastq)"  
       path_fastq="$(dirname $fastq_file)"
       srun -n 1 STAR --runThreadN 48 --outSAMtype BAM SortedByCoordinate --readFilesIn ${path_fastq}/${sample_file}_1.fastq ${path_fastq}/${sample_file}_2.fastq --genomeDir /shared/home/hchiapello/DUBii/module1/Ecoli_star/ --outFileNamePrefix ${sample_file}.fastq-star-out &
done
wait

```

Ce script sera lancé avec la commande `sbatch` :

```bash  
$ sbatch star_pairedfiles.sbatch /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq
```
**Questions** :      
- Combien de CPU seront utilisés pour chacune des task ?
- Regarder les ressources allouées à ce job en utilisant la commande `sacct`
