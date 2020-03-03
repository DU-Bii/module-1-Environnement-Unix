# Partie 2.1 : Recherche de fichiers ou de contenus

## Recherche de fichier : find
 
La commande `find` permet de rechercher des fichiers de manière récursive dans
un chemin à partir d'un motif.

Un motif est ici une expression ou une chaine de caractères correspondant au 
nom ou une partie du nom du fichier recherché

**Syntaxe** : `find [chemin] -name <MOTIF>`  

**Question 1** : Aller dans le répertoire `study-cases` et rechercher tous les
fichiers au format bed (i.e. dont l'extension est `.bed`)**

> **Solution :**: 
> > ```bash
> > $ find . -name "*.bed"
> > ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
> > ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed
> > ```
{:.answer}

## Recherche de contenu dans un fichier : grep  

La commande `grep` permet de rechercher et afficher les lignes contenant un
motif donné en argument dans un ou des fichiers donnés en argument.

Un motif est ici une expression ou une chaine de caractères correspondant à
l'élément recherché (un nom de gène, de protéine,...etc).

**Syntaxe** : `grep [options] <MOTIF> <FICHIERS>`

La commande grep a beaucoup d'options très utiles, par exemple :  

- `-i` : ignore les distinctions de casse dans le motif
- `-v` : sélectionne les lignes NE contenant PAS le motif
- `-n` : préfixe chaque ligne de sortie avec son numéro de ligne
- `-c` : affiche uniquement le nombre total de lignes contenant le motif  

**Question 2** : rechercher toutes les occurences du gène 'oriC' en affichant le
numéro de ligne de chaque occurence dans le fichier 
Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3**

> **Solution :**: 
> > ```bash
> >  grep -ni "oric" Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3
> >  4859:Chromosome    ena gene    1028404 1028721 .   -   .   ID=gene:b0966;Name=hspQ;biotype=protein_coding;description=heat shock protein involved in degradation of mutant DnaA%3B hemimethylated oriC DNA-binding protein;gene_id=b0966;logic_name=ena
> >  8256:Chromosome    ena gene    1704949 1705164 .   +   .   ID=gene:b1625;Name=cnu;biotype=protein_coding;description=nucleoid-associated oriC-binding protein%3B H-NS and StpA stabilizing factor;gene_id=b1625;logic_name=ena
> >  18950:Chromosome   ena_rep_origin  biological_region   3925744 3925975 .   +   .   external_name=oriC%3B origin of chromosomal DNA replication%2C bidirectional%3B oriC%3B b4489%3B ECK3735%3B JWS0001;logic_name=ena_rep_origin
> >  22228:Chromosome   ena gene    4634441 4635310 .   -   .   ID=gene:b4396;Name=rob;biotype=protein_coding;description=right oriC-binding transcriptional activator%2C AraC family;gene_id=b4396;logic_name=ena
> >  
> > ```
{:.answer}

# Partie 2.2 : Extraction des données d'un fichier 

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

**Question 3** : Rendez-vous dans le répertoire `Escherichia_coli/bacterial-regulons_myers_2013/data/RNA-seq`.
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

**Question 4** : Extraire la 2ème colonne 'WT1' du fichier `cutadapt_bwa_featureCounts_all.tsv`
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

**Question 5** : Éliminer les lignes dupliquées du fichier `cutadapt_bwa_featureCounts_WT1_sorted.tsv`
et écrire le résultat dans le fichier `cutadapt_bwa_featureCounts_WT1_sorted_uniq.tsv`    

> **Solution :**  
> > ```bash  
> > $ uniq cutadapt_bwa_featureCounts_WT1_sorted.tsv > cutadapt_bwa_featureCounts_WT1_sorted_uniq.tsv
> > ```
{:.answer}


## wc

La commande `wc` (*word count*) permet de compter le nombre de lignes, de mots
et de caractères du fichier ou des fichiers donnés en argument.

**Question 6** : Comment afficher uniquement le nombre de lignes d'un fichier ?
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


# Partie 2.3 : redirection des flux d'entrée et sortie et "|"

## Sauver le résultat d'une commande Linux dans un fichier : notion de redirection

La possibilité de redirection de l'entrée ou de la sortie standard est une
notion fondamentale du système d'exploitation Linux.

Par défaut tout programme Linux a trois flots de direction :

- une **entrée standard**, appelée `stdin` par défaut associée au **clavier**
- une **sortie standard**, appelée `stdout`, par défaut associée à **l'écran**
- une **erreur standard** appelée `stderr`, par défaut associée à **l'écran**

Une redirection est une modification de l’une de ces associations.
Elle est valable uniquement le temps de la commande sur laquelle elle porte.

Pour modifier l'entrée standard d'une commande en lisant les données d'un
fichier `infile` on utilise `< infile`.

Pour modifier la sortie standard d'une commande et écrire les résultats dans un
fichier `outfile` on utilise `> outfile` ou `>> outfile`

Pour modifier l'erreur standard d'une commande et écrire les messages d'erreurs
dans un fichier `errfile` on utilise : `2> errfile`.

En résumé tout programme Linux peut s'écrire
`$program < infile > outfile 2> errfile`

**Question 7**: rediriger le résultat de la commande `cat` sur le fichier
`ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed` dans le fichier `test.txt`.
Que contient le fichier `test.txt` ?

> **Réponse**
> > ```bash
> > $ cat ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed > test.txt
> > ```
> `cat` affiche le contenu de `ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed`.
> `>` redirige la sortie de la commande vers le fichier `test.txt`.
> Finalement, le fichier `test.txt` contient le contenu du fichier `ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed`.
{:.answer}

## Le pipe `|`

Le `|` est une manière simple et élégante d'enchainer des commandes sous Unix.
Nous avons déjà vu qu'il est possible de rediriger l'entrée, ou la sortie standard,
ou la sortie erreur d'une commande vers un fichier de son choix.

Le `|` permet rediriger la sortie d'une commande vers l'entrée d'une autre commande.
On peut enchainer un nombre pratiquement illimité de commandes grâce à des pipes.

**Question 8** : Comment afficher page par page le nombre d'occurences de chaque
valeur de la colonne `WT1` du fichier `cutadapt_bwa_featureCounts_all.tsv` en 1 seule commande ?**

> **Solution :** 
> > ```bash 
> > $ cut -f 2 cutadapt_bwa_featureCounts_all.tsv | sort | uniq -c | less
> > ```
{:.answer}


**Question 9** : Utiliser le `|` et les commandes précédentes pour déterminer le nombre de gènes uniques dans le fichier `Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`  
Le fichier est dans le répertoire /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/  
>
> **Solution :**  
>
> > ```bash  
> > $ cut -f 9 /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 | cut -d';' -f 1 | grep 'gene' | sort -u | wc -l  
$ 4498  
> > ```
{:.answer}

[Retour au sommaire](index.md)
