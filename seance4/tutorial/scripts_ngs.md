# Mise en pratique : exemple de scripts pour l'analyse de données NGS en utilisant les ressources du cluster NNCR  

## Connnection au cluster NNCR IFB

```bash
$ ssh <username>@core.cluster.france-bioinformatique.fr
```


## Le jeu de données

On dispose de 2 échantillons de reads pairés de *E. coli* : WT (Wild Type) et dFNR (mutant du gène FNR).  
Il y a 2 répliques par échantillons (soient 4 échantillons et 8 fichiers, les paires de reads étant stockées dans 2 fichiers séparés) :

```bash
$ ls  /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/*.fastq
/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR1_1.fastq
/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR1_2.fastq
/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR2_1.fastq
/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR2_2.fastq
/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT1_1.fastq
/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT1_2.fastq
/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT2_1.fastq
/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT2_2.fastq
```

## Exercice 1 - Scripts bash pour faire du contrôle qualité 

### Question 1.1 : Ecrire 3 scripts bash pour lancer sur le cluster de l'IFB 8 calculs `fastqc` correspondant aux 8 fichiers fastq à analyser  
- Un premier script basique qui n'utilise pas la parallélisation mais lance séquenciellement le traitement sur les 8 fichiers en utilisant une boucle
- Un deuxième script qui utilise la version multi-threadée de fastqc sur 6 threads et qui lance en une seule commande le traitement des 8 fichiers fastq
- Un troisième script qui lance en parallèle les 8 jobs en utilisant l'option `--array` de `sbatch`
#### Conseils :  
- Ces 3 scripts devront prendre en argument sur la ligne de commande le répertoire des fichiers fastq : /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/
- Créer dans votre script bash un répertoire pour les résultats fastqc dans votre répertoire courant, par exemple fastqc-results-v1
- Renommer de manière explicite les noms des fichiers de sortie et d'erreur de SLURM avec un nom explicite (version du script et  process id)
- N'oublier pas charger le logiciel dans le script bash avec la commande `module load`

> **Réponse script v1 (aucune parallélisation) :**
> > ```bash
> > $ cat fastqc_v1.sh  
> > #! /bin/bash
> > #SBATCH -o fastq_v1_slurm.%j.out           # STDOUT
> > #SBATCH -e fastq_v1_slurm.%j.err           # STDERR
> >
> > module load fastqc/0.11.8 
> >  
> > output_dir="fastqc-results-v1"  
> > mkdir -p ${output_dir}
> >
> > data=$(ls $1/*.fastq)    
> > for fastqc_file in ${data[@]}  
> > do 
> >      srun fastqc --quiet  ${fastqc_file} -o ${output_dir} &  
> > done
>>```
{:.answer}

> **Réponse script v2 (version multithreadée de fastqc avec 6 threads :**
> > ```bash
> > $ cat fastqc_v2.sh  
> > #! /bin/bash  
> > #SBATCH --cpus-per-task 6
> > #SBATCH -o fastq_v2_slurm.%j.out           # STDOUT
> > #SBATCH -e fastq_v2_slurm.%j.err           # STDERR
> > module load fastqc/0.11.8
> >
> > output_dir="fastqc-results-v2"
> > mkdir -p ${output_dir}
> >
> > data=($1/*.fastq)  
> > srun fastqc -t 6 --quiet  ${data[@]} -o ${output_dir} &  
> > 
>>```
{:.answer}

> **Réponse script v3 (version multithreadée de fastqc avec 16 threads avec execution des 8 jobs en parallème):**:
> > ```bash 
> > $ cat ./fastqc_v3.sh
> > #! /bin/bash
> > #SBATCH --array=0-7
> > #SBATCH -o fastq_v3_slurm.%j.out           # STDOUT
> > #SBATCH -e fastq_v3_slurm.%j.err           # STDERR
> > module load fastqc/0.11.8
> >
> > output_dir="fastqc-results-v3"
> > mkdir -p ${output_dir}
> >
> > FASTQ_FILES=($1/*.fastq)  
> > srun fastqc --quiet ${FASTQ_FILES[$SLURM_ARRAY_TASK_ID]} -o ${output_dir} 
> >```
{:.answer}

> > Pour lancer ces scripts on utilise la commande suivante :
> > ```bash  
> > $ sbatch ./fastqc_v1.sh /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/
> > $ sbatch ./fastqc_v2.sh /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/
> > $ sbatch ./fastqc_v3.sh /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/
> > 
> > ```
{:.answer}

### Question 1.2  : Comparer les ressources et temps d'execution obtenus pour les 3 scripts 
Utiliser pour cela la commande `sacct`

> **Réponse**
> > Pour regarder les ressources allouées à un job, on peut utiliser la commande 
> > ```bash 
> > $ sacct --format=JobID,JobName,NCPU,CPUTime,Elapsed,State -j <id-du-job>
> > ```
{:.answer}



## Exercice 2: mapping des reads sur le génome de *E. coli*

Nous allons créer un nouveau script bash qui utile **BWA** pour aligner les reads RNAseq sur le génome de *E. coli*.  

Pour pouvoir utiliser BWA il faut d'abord indexer le génome de référence avec la commande `bwa-index` 

```bash  
$ srun bwa index /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/genome/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.dna.chromosome.Chromosome.fa
```


Une fois l'index créé, nous allons utiliser un script `bwa_pairedfiles.sh` permettant de lancer un mapping BWA sur toutes les paires de fichiers fatsq d'un répertoire donné en argument.
### Conseils
- Utiliser le programme `bwa-mem`et regarder la syntaxe et les options au préalable en tapant `$ bwa-mem`
- Utiliser les commandes `basename` et `dirname` pour extraire les noms des fichiers fastq et leur répertoire source
- Votre script devra utiliser le multi-threading pour bwa mem et les job-steps (tasks) pour les fichiers à traiter


> **Solution**
```bash
$ cat bwa_pairedfiles.sh
#! /bin/bash

#SBATCH --ntasks=4  # 4 job steps ou tasks
#SBATCH --cpus-per-task=14  # 14 cpus (threads) par tache
#SBATCH -o bwa_v1.%N.%j.out           # STDOUT
#SBATCH -e bwa_v1.%N.%j.err           # STDERR

module load bwa/0.7.17

REP_FASTQ_FILES=$1
R1_fastq_files=$(ls $1/*_1.fastq)

for fastq_file in ${R1_fastq_files[@]}
do
       sample_file="$(basename $fastq_file _1.fastq)"
       path_fastq="$(dirname $fastq_file)"
       srun -n 1 -N 1 --cpus-per-task=14 bwa mem /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/genome/Escherichia_col
i_str_k_12_substr_mg1655.ASM584v2.dna.chromosome.Chromosome.fa  ${path_fastq}/${sample_file}_1.fastq ${path_fastq}/${sample_file}_2.fastq -t 14 > ./${sample_file}.sam  &  

done
wait 
```


Ce script sera lancé avec la commande `sbatch` :

```bash  
$ sbatch bwa_pairedfiles.sh /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq
```
{:.answer}

**Question** : Regarder les ressources allouées à ce job en utilisant la commande `sacct`
