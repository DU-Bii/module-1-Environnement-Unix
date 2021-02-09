
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

Utiliser le `|` et les commandes précédentes pour déterminer le nombre de gènes uniques dans le fichier `Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`  

--

```bash
$ cut -f 9 ~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 | cut -d ";" -f 1 | grep "ID=gene" | sort -u | wc -l
4497
```

---

class: left, top

# Question 2

Créer une archive du dossier `study-cases` ne contenant pas le répertoire `.git`

--

```bash
tar cvf study-cases.tar --exclude ".git" ~/dubii/study-cases
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

**Question** : copier le répertoire `study-cases` dans le répertoire `/tmp`

--

```bash
$ rsync -av ~/dubii/study-cases /tmp
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

**Solution** :

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

**Question**: écrire le script `unique-genes.bash` qui affiche le nombre de gènes
unique dans le fichier `~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`

--

**Solution** :

Avec un éditeur de texte créer le fichier `unique-genes.bash` contenant :


```bash
cut -f 9 ~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 | cut -d ";" -f 1 | grep "ID=gene" | sort -u | wc -l
```

--

## Éxécution du script

```bash
$ bash unique-genes.bash
4497
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
echo ${my_variable}
```

--

```bash 
# ou encore
echo "La valeur de la my_variable est ${my_variable}"
```

---

# Bash : les variables

## Exercice : modifier `unique-genes.bash`

**Question** : modifier le script `unique-genes.bash` de sorte que 
le nom du fichier gff soit stocké dans une variable et que cette variable
soit utilisée dans la suite du script.

--

**Solution** :

```bash
input_gff=~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3

cut -f 9 ${input_gff} | cut -d ";" -f 1 | grep "ID=gene" | sort -u | wc -l
```

```bash
$ bash unique-genes.bash
4497
```

---

class: left, top

# Bash : stocker la sortie d'une commande

**Syntaxe**: `$(<command> [arguments])`

--

**Exemple** : stocker le répertoire courant dans une variable

```bash
workdir=$(pwd)

# Prints the current working directory.
echo "The current working directory is ${workdir}.
```

---

# Bash : stocker la sortie d'une commande

**Question** : modifier le script `unique-genes.bash` pour qu'il stocke
le nombre de gènes dans une variable et l'affiche sous la forme
`Number of unique genes: 4497`

--

**Solution** :

```bash
input_gff=~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3

n=$(cut -f 9 ${input_gff} | cut -d ";" -f 1 | grep "ID=gene" | sort -u | wc -l)

echo "Number of unique genes: ${n}"
```

```bash
$ bash unique-genes.bash
Number of unique genes: 4497
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

**Exemple** :

```bash
input_gff_list=*.gff

for input_gff in ${input_gff_list}
do
    n=$(cut -f 9 ${input_gff} | cut -d ";" -f 1 | grep "ID=gene" | sort -u | wc -l)
    echo "${input_gff}: ${n}"
done
```

---

class: middle, center

[https://devhints.io/bash](https://devhints.io/bash)

