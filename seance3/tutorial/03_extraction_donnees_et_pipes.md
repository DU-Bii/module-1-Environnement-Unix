# Partie 3 : Extraction des données d'un fichier et gestion de flux

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

Suite : [Notions sur les expressions régulières](04_regex.md)