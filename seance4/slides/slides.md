
class: center, middle

# Unix 4

## DU-Bii 2020

Hélène Chiapello<br/>
Benoist Laurent<br/>
Pierre Poulain


.footer[
https://du-bii.github.io/module-1-Environnement-Unix/
]

.footer[
https://du-bii.github.io/module-1-Environnement-Unix/
]

---

class: center, middle
# Révisions & corrections des exercices

---

class: left, top

# Question 1

Utiliser le `|` et les commandes précédentes pour déterminer le nombre de gènes uniques dans le fichier `study_cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`  

--

```bash
$ cut -f 9 study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 | cut -d ';' -f 1 | grep 'gene' | sort -u | wc -l
4498
```

---

class: left, top

# Question 2

Créer une archive du dossier `study-cases` ne contenant pas le répertoire `.git`

--

```bash
tar cvf study-cases.tar --exclude ".git" study-cases
```

---

class: center, middle
# rsync

---

class: left, top
# rsync

- Copie (synchronisation) de fichier
- Alternative plus puissante à `cp`
- Copie seulement les fichiers plus récents
- Capable d'exclure des fichiers
- Capable de copie depuis/vers un serveur distant
- ...

---

class: left, top

# rsync : les options les plus courantes

- `-a, --archive` mode archive (typiquement ce qu'on veut 95% du temps)
- `-v, --verbose` mode verbeux  (afficher les éléments au fur et à mesure qu'il sont copiés)
- `-P, --progress` montre l'avancement, fichier par fichier
- `-h, --human-readable` montre les tailles au format humain (à utiliser avec `-P`)
- `-x, --exclude <MOTIF>` exclut des éléments de la copie.

---

class: left, top

# rsync : copie simple

**Question** : copier le répertoire `study-cases` tant le répertoire `/tmp`

--

```bash
$ rsync -av study-cases /tmp
rsync -av study-cases /data/
building file list ... done
study-cases/
study-cases/.gitignore
study-cases/LICENSE.txt
study-cases/README.md -> study-cases.md
study-cases/_config.yml
...
```

---

class: left, top

# rsync : copie depuis un serveur distant

**Question** : copier les fichiers FastQ présents sur le cluster de l'IFB dans le répertoire
`/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/` en affichant la progression.

--

```bash
$ rsync -aPh  <username>@core.cluster.france-bioinformatique.fr:/shared/projects/dubii2020/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/*.fastq .
```

---

class: center, middle
# Scripting

---

# Bash

- Un langage interprété

--

- Possède toutes les caractéristiques d'un langage de programmation
    - variables
    - fonctions
    - conditions
    - arithmétique
    - ...

---

class: left, top

# Bash : écriture d'un script

## Écriture du script

**Question**: écrire le script `first-line.bash` qui affiche la première ligne
des fichiers `bed` présents dans `./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq`

--

```bash
head -1 ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/*.bed
```

--

## Éxécution du script

```bash
$ bash first-line.bash
==> ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed <==
# HOMER Peaks

==> ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_macs2.bed <==
Chromosome	0	1023	FNR1_vs_input1_cutadapt_bowtie2_macs2_peak_1	26744	.	9.21896	2677.47827	2674.42871	173
```

---

class: left, top

# Bash : les variables

## Définition

```bash
my_variable=42
```

--

## Affichage

```bash 
$ echo ${my_variable}
42
```

---

class: left, top

# Bash : stocker la sortie d'une commande

**Syntaxe**: `$(<command> [arguments])`

--

```bash
fastq_files=$(ls ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/*.bed)
```

--

**Question** : écrire le script `nb-lignes.bash` qui affiche le nombre de lignes 
du fichier `Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3` sous la forme `nombre de lignes : <nombre>`

-- 

```bash
n=$(wc -l Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3)

echo "nombre de lignes : ${n}"
```

---

class: left, top

# Bash : les boucles

**Syntaxe** :

```bash
for <variable_name> in <list>
do
    <instructions>
done
```

--

```bash
for filename in $(ls *.bed)
do
    echo "$filename: $(wc -l $filename|cut -f 1 -d ' ') lines"
done
```

---

class: middle, center

https://devhints.io/bash

