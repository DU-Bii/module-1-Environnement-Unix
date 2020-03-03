
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

# Nombre d'outils, autant de syntaxes



.middle[.center[grep ≠ sed ≠ awk ≠ Python]]