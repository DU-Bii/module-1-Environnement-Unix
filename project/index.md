# Projet Unix

Pour ce projet Unix, vous allez aligner des *reads* de séquences du Sars-Cov-2 d'échantillons de patients sur le génome de réference de Sars-Cov-2.

## Présentation des données

Les fichiers de données au format `.fastq.gz` se trouvent sur le cluster dans le répertoire 
```
/shared/projects/dubii2021/trainers/module1/project/fastq
```

Vous disposez chacun d'un jeu de fichiers différents à analyser :

| Nom du répertoire | stagiaire  |
|:-----------------:|:----------:|
| 00 | démo       |
| 01 | Harry      |
| 02 | Marianne   |
| 03 | Gaël       |
| 04 | Sophie |
| 05 | Nicolas |
| 06 | Camille |
| 07 | Elodie |
| 08 | Emmanuelle |
| 09 | Alexandre |
| 10 | Domitille |
| 11 | Marika |
| 12 | Maria |
| 13 | Gaëlle |
| 14 | Magali |
| 15 | Luc |
| 16 | Vichita |
| 17 | Natalia |
| 18 | Fabienne |
| 19 | Lucie |

Remarque : dans chaque répertoire, le nombre de fichiers à analyser varie entre 30 et 60.

Depuis le Jupyter Hub, ouvrez un terminal Bash.


**Question 1** Comptez le nombre de fichiers `.fastq.gz` dans le répertoire qui vous a été attribué.

Vous utiliserez pour cela la commande `ls` combinée avec la commande `wc -l`.


## Préparation du répertoire de travail

Dans votre répertoire projet `/shared/projects/dubii2021/<login>` créez le répertoire `dubii-unix-project` puis dirigez-vous dans ce répertoire.

**Question 2** Affichez le chemin absolu de votre répertoire courant.


## Particularité des données proposées

Les données que vous allez analyser sont *paired-end*, c'est-à-dire que les *reads* vont par paires, un sur chaque brin. Ces *reads* doivent donc être alignés ensemble. Concrètement, pour chaque échantillon, on a deux fichiers `.fastq.gz`, par exemple :
```
SRR13764654_1.fastq.gz
SRR13764654_2.fastq.gz
SRR13764655_1.fastq.gz
SRR13764655_2.fastq.gz
SRR13764656_1.fastq.gz
SRR13764656_2.fastq.gz
```
Ici, l'échantillon `SRR13764654` est associé aux fichiers `SRR13764654_1.fastq.gz` et `SRR13764654_2.fastq.gz`.

La bonne nouvelle est que logiciel bowtie2 est capable d'aligner des *reads* *paired-end*. Il faut par contre lui donner dans la même commande les deux fichiers `.fastq.gz` concernés.


## Stratégie pour le *paired-end*

Comme l'a expliqué Julien, la bonne stratégie pour distribuer des analyses sur un cluster est celle du job array. Mais si le répertoire de données contient 30 fichiers `.fastq.gz` il ne faudra pas créer un job array de 30 jobs car en *paired-end*, les fichiers `.fastq.gz` sont associés deux à deux.

Dans l'exemple :
```
SRR13764654_1.fastq.gz
SRR13764654_2.fastq.gz
SRR13764655_1.fastq.gz
SRR13764655_2.fastq.gz
SRR13764656_1.fastq.gz
SRR13764656_2.fastq.gz
```
Il faudra un premier job pour traiter les fichiers `SRR13764654_1.fastq.gz` et `SRR13764654_2.fastq.gz`, un deuxième pour les fichiers `SRR13764655_1.fastq.gz` et `SRR13764655_2.fastq.gz` et troisième pour les fichiers `SRR13764656_1.fastq.gz` et `SRR13764656_2.fastq.gz`.

Heureusement, les fichiers ont été nommés intelligemment et on retrouve facilement les deux fichiers associés au même échantillon en ajoutant les extensions `_1.fastq.gz` et `_2.fastq.gz`.

L'astuce va donc être de créer un job array uniquement pour les fichiers `_1.fastq.gz` (puisque leurs binômes `_2.fastq.gz` sont toujours présents).

Par exemple pour aligner les *reads* des fichiers `.fastq.gz` du répertoire `/shared/projects/dubii2021/trainers/module1/project/fastq/00`, on peut utiliser le script `map_reads.sh` suivant :

```
#!/bin/bash

#SBATCH --array=0-14
#SBATCH --cpus-per-task=10
#SBATCH --mem=1G

module load bowtie2/2.4.1 samtools/1.10

reference_index="/shared/projects/dubii2021/trainers/module1/project/genome/sars-cov-2"
file_path="/shared/projects/dubii2021/trainers/module1/project/fastq/00"

file_list=(${file_path}/*_1.fastq.gz)
file_id=$(basename -s _1.fastq.gz "${file_list[$SLURM_ARRAY_TASK_ID]}")

echo "Accession: ${file_id}"
echo "R1: ${file_path}/${file_id}_1.fastq.gz"
echo "R2: ${file_path}/${file_id}_2.fastq.gz"

srun -J "${file_id} bowtie2" bowtie2 --threads=${SLURM_CPUS_PER_TASK} -x "${reference_index}" -1 "${file_path}/${file_id}_1.fastq.gz" -2 "${file_path}/${file_id}_2.fastq.gz" -S "${file_id}.sam"

srun -J "${file_id} filter" samtools view -hbS -q 30 -o "${file_id}.filtered.bam" "${file_id}.sam"

srun -J "${file_id} sort" samtools sort -o "${file_id}.bam" "${file_id}.filtered.bam"

rm -f "${file_id}.sam" "${file_id}.filtered.bam"
```

Le répertoire `/shared/projects/dubii2021/trainers/module1/project/fastq/00` contient 30 fichiers `.fastq.gz`, mais le job array n'est lancé que pour 15 jobs :
```
#SBATCH --array=0-14
```

On ne récupère que les fichiers `_1.fastq.gz` pour ensuite extraite le `file_id` du fichier :
```
file_list=(${file_path}/*_1.fastq.gz)
file_id=$(basename -s _1.fastq.gz "${file_list[$SLURM_ARRAY_TASK_ID]}")
```

Enfin, on remplace l'option `-U` de `bowtie2` utilisée pour faire du *single end* par les options `-1` et `-2` pour faire cette fois du *paired end*.






