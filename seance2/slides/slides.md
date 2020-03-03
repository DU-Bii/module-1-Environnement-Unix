
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

$ # Seule les fichiers .bed
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

Rechercher tous les noms de gènes nommés dnaA, dnaB, dnaC
et dnaD dans le fichier
`Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`

--

```bash
$ grep -e "dna[A-D]" Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 

---