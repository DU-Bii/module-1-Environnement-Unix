# Partie 1 : Révision et consolidation des deux séances précédentes 
- **Arborescence Linux** : fichiers, répertoires,etc...
- **Contenu d'un fichier** : savoir affichier le contenu d'un fichier et travailler avec l'éditeur **nano**
- **Commandes Linux** : aide sur une commande, historique et répétiton des commandes. Redirection des entrées, sorties et erreurs standarts.
- **Accès aux ressources de cluster NNCR** : savoir accéder et utiliser les ressources du cluster NNCR. Savoir transférer ses données dans un répertoire ad-hoc, savoir organiser ses fichiers et répertoires (bonnes pratiques en bioinfo)

# Partie 2 : Recherche de fichiers ou de contenus

## find

La commande `find` permet de rechercher des fichiers de manière récursive dans
un chemin à partir d'un motif.

Un motif est ici une expression ou une chaine de caractères correspondant au 
nom ou une partie du nom du fichier recherché

**Syntaxe : `find [chemin] -name <MOTIF>`**  

**Question 1 : Aller dans le répertoire `study-cases` et rechercher tous les
fichiers au format bed (i.e. dont l'extension est `.bed`)**

> **Solution :**: 
> > ```bash
> > $ find . -name "*.bed"
> > ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
> > ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed
> > ```
{:.answer}

## grep  

La commande `grep` permet de rechercher et afficher les lignes contenant un
motif donné en argument dans un ou des fichiers donnés en argument.

Un motif est ici une expression ou une chaine de caractères correspondant à
l'élément recherché (un nom de gène, de protéine,...etc).

**Syntaxe : `grep [options] <MOTIF> <FICHIERS>`**

La commande grep a beaucoup d'options très utiles, par exemple :  

- `-i` : ignore les distinctions de casse dans le motif
- `-v` : sélectionne les lignes NE contenant PAS le motif
- `-n` : préfixe chaque ligne de sortie avec son numéro de ligne
- `-c` : affiche uniquement le nombre total de lignes contenant le motif  

**Question 2 : rechercher toutes les occurences du gène 'oriC' en affichant le
numéro de ligne de chaque occurence dans le fichier 
Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3**

> **Solution :**: 
> > ```bash
> >  grep -ni "oric" Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3
> >  4859:Chromosome	ena	gene	1028404	1028721	.	-	.	ID=gene:b0966;Name=hspQ;biotype=protein_coding;description=heat shock protein involved in degradation of mutant DnaA%3B hemimethylated oriC DNA-binding protein;gene_id=b0966;logic_name=ena
> >  8256:Chromosome	ena	gene	1704949	1705164	.	+	.	ID=gene:b1625;Name=cnu;biotype=protein_coding;description=nucleoid-associated oriC-binding protein%3B H-NS and StpA stabilizing factor;gene_id=b1625;logic_name=ena
> >  18950:Chromosome	ena_rep_origin	biological_region	3925744	3925975	.	+	.	external_name=oriC%3B origin of chromosomal DNA replication%2C bidirectional%3B oriC%3B b4489%3B ECK3735%3B JWS0001;logic_name=ena_rep_origin
> >  22228:Chromosome	ena	gene	4634441	4635310	.	-	.	ID=gene:b4396;Name=rob;biotype=protein_coding;description=right oriC-binding transcriptional activator%2C AraC family;gene_id=b4396;logic_name=ena
> >  
> > ```
{:.answer}


# Partie 3  : Extraction des données d'un fichier et gestion de flux

## cut  

La commande `cut` permet d'extraire une ou plusieurs colonnes d'un fichier.

L'option `-c` permet d'utiliser *les positions des caractères* dans le fichier
(cad dire les numéro des colonnes).

Exemple : extraction des caractères 1 à 10 d'un fichier

```bash
$ cut -c 1-10 <FILE>
```

L'option `-f` permet de spécifier *les positions des champs (fields)* dans le fichier. 
Le délimitateur par défaut est la tabulation, on peut le changer avec l'option `-d`.

Exemple : extraction de la deuxième colonne d'un fichier au format csv

```bash
$ cut -d "," -f 2 <CSV_FILE>
```


**Question 3 : Rendez-vous dans le répertoire `Escherichia_coli/bacterial-regulons_myers_2013/data/RNA-seq`.
Extraire de deux manières différentes la colonne Geneid du fichier `cutadapt_bwa_featureCounts_all.tsv`**

> **Solution :**   
> > ```bash
> > $ cut -f 1 cutadapt_bwa_featureCounts_all.tsv 
> > [...]
> > b4400
> > b4401
> > b4402
> > b4403
> > $ cut -c 1-6 cutadapt_bwa_featureCounts_all.tsv
> > [...]
> > b4400
> > b4401
> > b4402
> > b4403
> > ```
{:.answer}


## sort  

La commande `sort` permet de trier les lignes du ou des fichiers donnés en argument  
**Attention**: le tri par défaut est selon le code ASCII et pas selon 
l'ordre numérique.
Pour faire un tri numérique utiliser l'option `-n`.

**Question 4 : Extraire la 2ème colonne 'WT1' du fichier `cutadapt_bwa_featureCounts_all.tsv`
en redirigeant le résultat dans un fichier de sortie 'cutadapt_bwa_featureCounts_WT1.tsv'.
Trier ensuite les valeurs de ce fichier par ordre croissant et écrire le résultat
dans le fichier `cutadapt_bwa_featureCounts_WT1_sorted.tsv`.

> **Solution :**  
> > ```bash  
> > cut -f 2 cutadapt_bwa_featureCounts_all.tsv > cutadapt_bwa_featureCounts_WT1.tsv
> > sort -n cutadapt_bwa_featureCounts_WT1.tsv > cutadapt_bwa_featureCounts_WT1_sorted.tsv
> > ```
{:.answer}


## uniq  

La commande `uniq` permet d'éliminer les lignes identiques *et consécutives* d'un fichier.
Pour éliminer les lignes répétées sur l'ensemble d'un fichier, il est donc nécessaire
de trier le fichier avant d'utiliser la commande `uniq`.

Les options les plus couramment utilisées de `uniq` sont :  

- `-c` pour afficher le nombre d'occurences de chaque ligne,
- `-d` pour afficher les lignes dupliquées,
- `-i` pour ignore la casse.

**Question 5 : Éliminer les lignes dupliquées du fichier `cutadapt_bwa_featureCounts_WT1_sorted.tsv`
et écrire le résultat dans le fichier `cutadapt_bwa_featureCounts_WT1_sorted_uniq.tsv`    

> **Solution :**  
> > ```bash  
> > uniq cutadapt_bwa_featureCounts_WT1_sorted.tsv > cutadapt_bwa_featureCounts_WT1_sorted_uniq.tsv
> > ```
{:.answer}


## wc

La commande `wc` (*word count*) permet de compter le nombre de lignes, de mots
et de caractères du fichier ou des fichiers donnés en argument.

**Question 6 : Comment afficher uniquement le nombre de lignes d'un fichier ?
Combien de lignes y a-t-il dans les fichiers `cutadapt_bwa_featureCounts_WT1_sorted.tsv` 
et `cutadapt_bwa_featureCounts_WT1_sorted_uniq.tsv` ?

> **Solution :** 
> > ```bash  
> > $ wc -l cutadapt_bwa_featureCounts_WT1_sorted.tsv
> > 4498 cutadapt_bwa_featureCounts_WT1_sorted.tsv
> > 
> > $ wc -l cutadapt_bwa_featureCounts_WT1_sorted_uniq.tsv
> > 1357 cutadapt_bwa_featureCounts_WT1_sorted_uniq.tsv
> > ```
{:.answer}


## Le pipe `|`

Le `|` est une manière simple et élégante d'enchainer des commandes sous Unix.
Nous avons déjà vu qu'il est possible de rediriger l'entrée, ou la sortie standard,
ou la sortie erreur d'une commande vers un fichier de son choix.

Le `|` permet rediriger la sortie d'une commande vers l'entrée d'une autre commande.
On peut enchainer un nombre pratiquement illimité de commandes grâce à des pipes.

**Question : Comment afficher page par page le nombre d'occurences de chaque
valeur de la colonne `WT1` du fichier `cutadapt_bwa_featureCounts_all.tsv` en 1 seule commande ?**

> **Solution :** 
> > ```bash 
> > $ cut -f 2 cutadapt_bwa_featureCounts_all.tsv | sort | uniq -c | less
> > ```
{:.answer}


**Question 7 : Utiliser le `|` et les commandes précédentes pour déterminer le nombre de gènes uniques dans le fichier `Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`    
>
> **Solution :**  
>
> > ```bash  
> >  cut -f 9 Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 | cut -d';' -f 1 | grep 'gene' | sort -u | wc -l  
> >  
> > ```
{:.answer}


# Partie 3 : Notions sur les expressions régulières  

## Les expressions de bases  

Une expression régulière (en anglais Regular Expression) sert à identifier une
chaîne de caractères répondant à un certain critère (par exemple chaîne
contenant un *motif* donné, c'est à dire un enchainement de certains types
de caractères).

De nombreux programmes utilisent les expressions régulières (par exemple `sed`,
`grep`, `vi`, ...) mais il est important de noter que leur syntaxe peut varier
d'un programme à l'autre.

Le design d'expressions régulières peut rapidement s'avérer complexe et nécessite
un savoir-faire certain.

Cette possibilité illustre cependant la puissance de l'environnement Unix 
pour spécifier des recherches et actions complexes en utilisant des lignes 
de commande concises.  

Les expressions régulières vont se baser sur des caractères spéciaux ou métacaractères :

- `.` correspond à n'importe quel caractère  
- `*` correspond à une répétition de 0 à n occurences (déconseillé) 
- `+` correspond à une répétition de 1 à n occurences 
- les caractères entre crochets (`[ ]`) correspondent à un ensemble de valeurs possibles (intervale ou explicites par exemple `[A-D]` est équivalent à [A,B,C,D]
- `^` indique une recherche d'un motif en début de ligne  
- `$` indique une recherche d'un motif en fin de ligne  

**Question 8 :** Rechercher tous les noms de gènes du fichier
`Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`
correspondant à oriA, oriB, oriC et oriD avec la commande `grep` et en
utilisant une expression régulière.

> **Solution :**  
> > ```bash 
> > $ grep -e "dna[A-D]" Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 
> > ```
{:.answer}


*Donner ici quelques sites de vérification des expressions régulières et des pointeurs de tutoriaux pour aller plus loin*

**to do**  

## sed  

`sed` (stream editor) est éditeur de texte non interactif permettant de filtrer et transformer les lignes du ou des fichier donnés en argument. La commande ne modifie pas le(s) fichier(s) traité(s)et écrit le résultat sur la sortie standard.  
La commande `sed` est très utile car elle permet de réaliser des commandes complexes sur des gros fichiers en utilisant des expressions régulières.  
**Syntaxe : `sed -e [expression] fichier-a-traiter`**  
La partie `expression` peut contenir des fonctions de filtrage ou de transformation des lignes du fichier-a-traiter  
Nous ne verrons ici que quelques cas d'utilisation très courants en bioinformatique.  

### Exemple 1 : Remplacer toutes les occurences d'une chaine de caractères dans un fichier  
Remplaçons toutes les occurences de `Chromosome` par `chr` dans le fichier Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3   
Pour cela on utilise la fonction de subsitution *s*  
`sed 's/Chromosome/chr/g' Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 > Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chr.gff3`

### Exemple 2 : Remplacer toutes les occurences d'une chaine de caractères dans un fichier  
Supprimons toutes les lignes contenant le nom `oriC` dans le fichier Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3  
Pour cela on utilise la fonction de suppression *d*  
`sed '/oriC/d' Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3  > Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome_wo_oriC.gff`

# Partie 4 : Espace de stockage, compression et archivage de données


## Gérer son espace disque : les commandes du et df
## Archiver avec tar
## gzip, gunzip
## Application des mêmes commandes sur des gros fichiers compressés (zless, zgrep, zcat)
## 2 exos max
