# Projet Unix

Pour ce projet Unix, vous allez aligner des *reads* de séquences du Sars-Cov-2 d'échantillons de patients sur le génome de réference de Sars-Cov-2.

*Nous vous conseillons de noter les réponses aux questions posées dans un fichier texte. Vous reporterez ensuite ces réponses dans un formulaire Google Form.*

## Présentation des données

Les fichiers de données au format `.fastq.gz` proviennent du projet [PRJNA673096](https://www.ncbi.nlm.nih.gov/sra/?term=PRJNA673096) sur SRA. Elles ont été produites par la technologie Illumina MiniSeq.

Les fichiers se trouvent sur le cluster dans le répertoire 
```
/shared/projects/dubii2021/trainers/module1/project/fastq
```

Vous disposez chacun d'un jeu de fichiers différents à analyser :

| Nom du répertoire | stagiaire  |
|:-----------------:|:----------:|
| 00 | démo |
| 01 | Harry |
| 02 | Marianne |
| 03 | Gaël |
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

Remarque : dans chaque répertoire, le nombre de fichiers à analyser varie entre 30 et 60 fichiers.

Depuis le Jupyter Hub, ouvrez un terminal Bash.


**Question 1** : Quel est le nombre exact de fichiers `.fastq.gz` que vous allez analyser ?

Indice : Vous utiliserez pour cela la commande `ls` combinée avec la commande `wc -l`.


**Question 2** : Quel est le volume de données total (en Go) des fichiers `.fastq.gz` que vous allez analyser ?


## Préparation du répertoire de travail

Dans votre répertoire projet `/shared/projects/dubii2021/<login>` créez le répertoire `dubii-unix-project` puis déplacez-vous dans ce répertoire.

Rappel : dans le chemin précédent, remplacez `<login>` par votre login sur le cluster.


**Question 3** : Quel est le chemin absolu de votre répertoire courant ?


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

La bonne nouvelle est que logiciel `bowtie2` est capable d'aligner des *reads* *paired-end*. Il faut par contre lui fournir dans la même commande les deux fichiers `.fastq.gz` concernés.


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
Il faudra un premier job pour traiter ensemble les fichiers `SRR13764654_1.fastq.gz` et `SRR13764654_2.fastq.gz`, un deuxième pour les fichiers `SRR13764655_1.fastq.gz` et `SRR13764655_2.fastq.gz` et un troisième pour les fichiers `SRR13764656_1.fastq.gz` et `SRR13764656_2.fastq.gz`.

Heureusement, les fichiers ont été nommés intelligemment et on retrouve facilement les deux fichiers associés au même échantillon en ajoutant les extensions `_1.fastq.gz` et `_2.fastq.gz` au numéro d'échantillon.

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

Le répertoire `/shared/projects/dubii2021/trainers/module1/project/fastq/00` contient 30 fichiers `.fastq.gz`, mais le job array n'est lancé que pour 15 jobs avec pour index 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 et 14 :
```
#SBATCH --array=0-14
```

On ne récupère que les fichiers `_1.fastq.gz` pour ensuite extraire le `file_id` du fichier :
```
file_list=(${file_path}/*_1.fastq.gz)
file_id=$(basename -s _1.fastq.gz "${file_list[$SLURM_ARRAY_TASK_ID]}")
```

Enfin, on remplace l'option `-U` de `bowtie2` utilisée pour réaliser des alignements en *single end* par les options `-1` et `-2` pour réaliser cette fois des alignements en *paired end* :
```
srun -J "${file_id} bowtie2" bowtie2 --threads=${SLURM_CPUS_PER_TASK} -x "${reference_index}" -1 "${file_path}/${file_id}_1.fastq.gz" -2 "${file_path}/${file_id}_2.fastq.gz" -S "${file_id}.sam"
```


## Faisons chauffer du CPU 🚀

Si ce n'est pas déjà fait, déplacez vous dans votre répertoire `/shared/projects/dubii2021/<login>/dubii-unix-project`.

Créez dans ce répertoire le script `map_reads.sh` avec un éditeur de texte (nano ou l'éditeur de texte de Jupyter Lab). Faites attention lors du copier/coller car certaines lignes sont très longues.

Ne modifiez pas le script et lancez-le tel quel avec la commande :
```
sbatch map_reads.sh
```

**Question XX** : Quel est le job id de votre job ?


Suivez l'évolution du calcul avec la commande
```
sacct --format=JobID%20,JobName%20,State,Start,Elapsed,CPUTime,NodeList -j <votre-job-id>
```
où bien sûr vous remplacez `<votre-job-id>` par votre job id.

Vérifiez que toutes les tasks ont progressivement le status `COMPLETED`.

**Question XX** : Sur quel noeud du cluster s'est exécuté le premier job de votre job array (première ligne renvoyée par la commande `sacct` contenant `map_reads.sh`) ?


Pour la suite, faites un peu de ménage avec la commande :
```
rm -f SRR*.bam slurm*out
```

Attention, pas de retour arrière posible avec `rm` !


## Faisons chauffer du CPU encore une fois

Toujours depuis votre répertoire `/shared/projects/dubii2021/<login>/dubii-unix-project`, copiez le script `map_reads.sh` en `map_reads_2.sh`.

Ouvrez le script `map_reads_2.sh` avec un éditeur de texte (nano ou l'éditeur de texte de Jupyter Lab). Modifiez ce script pour l'adapter aux données qui vous ont été attribuées. Vous ne devez a priori modifier que deux lignes dans le script.

Lancez ensuite votre script :
```
sbatch map_reads_2.sh
```

Suivez l'évolution de votre script avec la commande `sacct`. Si votre script plante, essayez de comprendre ce qui se passe et de le corriger.

Conseil : si vous devez relancer plusieurs fois votre script, pensez à faire du ménage à chaque fois avec la commande 
```
rm -f SRR*.bam slurm*.out
```

Une fois que vous avez un job avec toutes les tasks `COMPLETED` : félicitation !


**Question XX** : Quel est le job id de votre job (lancé avec le script `map_reads_2.sh`) ?


**Question XX** : Combien de fichiers `.bam` avez-vous générés ?

Vérifiez que ce nombre est cohérent avec le nombre de fichiers `.fast.gz` que vous avez à analyser.


**Question XX** : Quel est le volume de données total (en Go) des fichiers `.bam` que vous avez générés ?


