
class: center, middle

# Unix 2

## DU-Bii 2020

Hélène Chiapello<br/>
Benoist Laurent

Pierre Poulain<br/>
Sandra Dérozier


.footer[
https://du-bii.github.io/module-1-Environnement-Unix/
]

---

class: center, middle
# Révisions de la séance 1


---

class: center, middle
# Les expressions régulières Unix

---

class: left, top

# Définition
Une expression régulière (en anglais *Regular Expression*) 
est une chaîne de caractères décrivant un ensemble de chaîne de
caractères.
--

```bash
$ # Liste des fichiers du répertoire courant
$ ls -lh 
total 232K
-rw-r--r-- 1 benoist staff 8.9K Mar  2 23:49 FNR1_vs_input1_cutadapt_bowtie2_homer.bed
-rw-r--r-- 1 benoist staff  45K Mar  2 23:49 FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
-rw-r--r-- 1 benoist staff  80K Mar  2 23:49 FNR_200bp.wig
-rw-r--r-- 1 benoist staff  90K Mar  2 23:49 input_200bp.wig

$ # Seulement les fichiers .bed
$ ls -lh *.bed
-rw-r--r-- 1 benoist staff 8.9K Mar  2 23:49 FNR1_vs_input1_cutadapt_bowtie2_homer.bed
-rw-r--r-- 1 benoist staff  45K Mar  2 23:49 FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
```

---

class: middle, center

# Nombre d'outils, autant de syntaxes

grep ≠ sed ≠ awk ≠ Python

---

# Métacaractères

- `.` correspond à n'importe quel caractère  
- `*` correspond à une répétition de 0 à n occurences (déconseillé) 
- `+` correspond à une répétition de 1 à n occurences 
- les caractères entre crochets (`[ ]`) correspondent à un ensemble de valeurs possibles (intervale ou explicites par exemple `[A-D]` est équivalent à [A,B,C,D]
- `^` indique une recherche d'un motif en début de ligne  
- `$` indique une recherche d'un motif en fin de ligne  

---

# Exercice

Rendez-vous dans le dossier `~/dubii/study-cases/Escherichia_coli`.

Rechercher tous gènes nommés dnaA, dnaB, dnaC et dnaD dans le fichier
`Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`

--

```bash
$ grep -e "dna[A-D]" Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 
```

---

# `sed` : *Stream Editor*

`sed` permet de filtrer et transformer les lignes d'un fichier passé
en argument.

```bash
$ # Syntaxe :
$ sed [expression] <fichier>
```

---

# `sed` : Exemple 1

Remplacer toutes les occurences de `Chromosome` par `chr`.

--

```bash
$ sed 's/Chromosome/chr/g' Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 > gff_modified.gff3
```

---

# `sed` : Exemple 2

Supprimer toutes les lignes contenant la chaîne de caractère `dnaC`

--

```bash
$ sed '/dnaC/d' Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 > gff_no-dnaC.gff3
```

---

class: center, middle
# Compression / Archivage

---

# Revisions

* Quantité d'espace disponible sur un disque : `df -h`
--

* Liste des fichiers avec leur taille : `ls -lh`
--

* Espace disque occupé par un dossier : `du -h`
--

* Trouver les fichiers volumineux : `find -size`

---

# Compression/décompression d'un fichier

La méthode la plus commune pour compresser un fichier est 
d'utiliser `gzip` :

```bash
$ ls -lh 12870_2016_726_MOESM10_ESM.tsv
-rw-r--r-- 1 benoist staff 1.6M Mar  2 23:49 12870_2016_726_MOESM10_ESM.tsv
$ gzip 12870_2016_726_MOESM10_ESM.tsv
$ ls -lh 12870_2016_726_MOESM10_ESM.tsv.gz
-rw-r--r-- 1 benoist staff 346K Mar  2 23:49 12870_2016_726_MOESM10_ESM.tsv.gz
```

---

# Compression/décompression d'un fichier

Pour décompresser ce fichier, utiliser `gunzip` : 

```bash
$ gunzip 12870_2016_726_MOESM10_ESM.tsv.gz
```

Autres outils de compression/décompression : `bzip2`, `7z`, ...

---

# Travailler avec des fichiers compressés

* `zless`
* `zcat`
* `zgrep`
* ...

* `bzless`
* `bzcat`
* `bzgrep`
* ...

---

# Réduire le nombre de fichier présents sur un disque

La commande `tar` permet de réunir plusieurs fichiers et/ou dossiers
en une seule archive :

```bash
$ # Création d'une archive
$ tar cvf <nom_de_l_archive> <liste_des_entrees>
```
--

```bash
$ # Désarchivage
$ tar xvf <nom_de_l_archive> <liste_des_entrees>
```
--

On peut compresser/décompresser à la volée en utilisant
les options `-z` (gzip) et `-j` (bzip2).

