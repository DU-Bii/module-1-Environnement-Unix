
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

**Question** : Utiliser le `|` et les commandes précédentes pour déterminer le nombre de gènes uniques dans le fichier `study_cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`  

--

```bash
$ cut -f 9 study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 | cut -d ';' -f 1 | grep 'gene' | sort -u | wc -l
4498
```

---

**Question** : créer une archive du dossier `study-cases` ne contenant pas le répertoire `.git`

--

```bash
tar cvf study-cases.tar --exclude ".git" study-cases
```

---

class: center, middle
# rsync

---

class: top, left
# rsync

- Alternative plus puissante à cp
- Copie seulement les fichiers plus récents
- Capable d'exclure des fichiers
- Capable de copie depuis/vers un serveur distant
- ...

