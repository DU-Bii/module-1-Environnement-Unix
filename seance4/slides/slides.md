
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

class: left, middle

**Question** : Utiliser le `|` et les commandes précédentes pour déterminer le nombre de gènes uniques dans le fichier `study_cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`  

--

```bash
$ cut -f 9 study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 | cut -d ';' -f 1 | grep 'gene' | sort -u | wc -l
4498
```

---

class: left, middle

**Question** : créer une archive du dossier `study-cases` ne contenant pas le répertoire `.git`

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

- Alternative plus puissante à cp
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
    - fonctions
    - conditions
    - arithmétique
    - ...
