# Mise en pratique : exemple de scripts Bash pour l'analyse de données NGS  

## Connnection au cluster NNCR IFB

Connectez-vous au cluster IFB via l'outil JupyterHub. Ouvrir deux terminaux : un pour éditer vos scripts avec `nano` et un pour les exécuter.


## Le jeu de données
TO DO : prendre 10% des reads de chaque FICHIER
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

### Question 1.1 : Ecrire un scripts bash pour lancer 8 calculs `fastqc` correspondant aux 8 fichiers fastq à analyser  
-
#### Conseils :  
- Ces 3 scripts devront prendre en argument sur la ligne de commande le répertoire des fichiers fastq : /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/
- Créer dans votre script bash un répertoire pour les résultats fastqc dans votre répertoire courant, par exemple fastqc-results-v1
- N'oublier pas charger le logiciel fasqc dans le script bash avec la commande `module load`
- Utiliser la version multithreadé de fastqc avec l'option -t 6

> **Réponse script v1 (aucune parallélisation) :**
> > ```bash
> > $ cat fastqc_v1.sh  
> > #! /bin/bash
> > module load fastqc/0.11.8 
> >  
> > output_dir="fastqc-results-v1"  
> > mkdir -p ${output_dir}
> >
> > data=(/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/*.fastq)
> > for fastqc_file in ${data[@]}  
> > do 
> >      fastqc -t 6 --quiet  ${fastqc_file} -o ${output_dir}
> > done
>>```
{:.answer}



## Exercice 2 - mapping des reads sur le génome de *E. coli*

Nous allons créer un nouveau script bash qui utile **BWA** pour aligner les reads RNAseq sur le génome de *E. coli*.  

Pour pouvoir utiliser BWA il faut d'abord indexer le génome de référence avec la commande `bwa-index` 

```bash  
$ srun bwa index /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/genome/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.dna.chromosome.Chromosome.fa
```

Une fois l'index créé, nous allons utiliser un script `bwa_pairedfiles.sh` permettant de lancer un mapping BWA sur toutes les paires de fichiers fatsq d'un répertoire donné en argument.
### Conseils
- Utiliser le programme `bwa-mem`et regarder la syntaxe et les options au préalable en tapant `$ bwa-mem`
- Utiliser les commandes `basename` et `dirname` pour extraire les noms des fichiers fastq et leur répertoire source
- Votre script devra utiliser le multi-threading pour `bwa mem` et les `job-steps` (tasks) pour les fichiers à traiter
- Pour pouvoir exécuter les job-steps (tasks) en parallèle, la commande srun doit se terminer par `&`
- Lorsque des `job-steps` sont exécutés en parallèle, le script parent (Job) doit attendre la fin de l'exécution des processus enfants avec un `wait`, sinon ces derniers seront automatiquement interrompus (killed) une fois la fin du batch atteinte


> **Solution**
> > ```bash 
> > $ cat bwa_pairedfiles.sh
> > #! /bin/bash
> > #SBATCH --ntasks=4  # 4 job steps ou tasks
> > #SBATCH --cpus-per-task=14  # 14 cpus (threads) par tache
> > #SBATCH -o bwa_paired_files.%j.out           # STDOUT
> > #SBATCH -e bwa_peired_files.%j.err           # STDERR
> >
> > module load bwa/0.7.17
> >
> > BASE_DIR="/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq"
> > R1_fastq_files=(${BASE_DIR}/*_1.fastq)
> >
> > for fastq_file in ${R1_fastq_files[@]}
> > do
> >        sample_file="$(basename $fastq_file _1.fastq)"
> >        path_fastq="$(dirname $fastq_file)"
> >        srun --cpus-per-task=14 bwa mem /shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterialregulons_myers_2013/genome/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.dna.chromosome.Chromosome.fa  ${path_fastq}/${sample_file}_1.fastq ${path_fastq}/${sample_file}_2.fastq -t 14 > ./${sample_file}.sam  &  
> > done
> > wait 
> >```
{:.answer}

> Ce script sera lancé avec la commande `sbatch` :  
> >
> >```bash  
> >$ sbatch bwa_pairedfiles.sh 
> >```
{:.answer}


**Question** : Regarder les ressources allouées à ce job en utilisant la commande `sacct`
