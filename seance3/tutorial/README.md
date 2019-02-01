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

**Syntaxe** : `find [chemin] -name <MOTIF>`  

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

**Syntaxe** : `grep [options] <MOTIF> <FICHIERS>`

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

**Syntaxe** : `sed -e [expression] fichier-a-traiter`

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

Il est de plus en plus facile d'obtenir de plus en plus de données.
Il est important d'être conscient des capacités de stockage de sa machine d'une part,
et du fait qu'un trop grand nombre de fichiers sur une machine peut engendrer
un crash pur et simple du système.

Ainsi, dans ce chapitre nous allons apprendre 

- comment savoir si un disque est plein,
- comment connaître la quantité d'espace disque occupé par un fichier/dossier,
- comment trouver les fichiers volumineux sur un disque,
- comment réduire la quantité d'espace disque occupé,
- comment réduire le nombre de fichiers présents sur un disque.


## Connaître la quantité d'espace disque occupée et disponible sur un disque

La commande `df` permet de connaître les quantités d'espace occupé et disponible
pour tous les disques du système.

**Question 9**: Quelle est la quantité d'espace disque disponible sur votre machine en `G` ?

> **Solution**
> > La commande à utiliser est `df -h`, l'option `-h` signifiant "human readable".
> > Autrement dit, cette option donne le résultat en M, G, T et non en B (défaut).
{:.answer}


## Connaître la quantité d'espace disque occupé par un fichier/dossier.

Comme vu précédemment, la commande pour connaître la taille des fichiers présents
dans un dossier est `ls -lh`.

**Question 10**: Rendez-vous dans le dossier `study-cases/Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016`.
Quelle est la quantité d'espace disque occupée par chacun des fichiers présents
dans ce répertoire ? Trier les fichiers du plus volumineux au moins volumineux.

> **Solution:**
> >$ cd study-cases/Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016
> >
> >$ # Afficher la taille des fichiers
> >$ ls -lh
> >total 24M
> >-rw-rw-r-- 1 laurent laurent 1.6M Feb  1 10:44 12870_2016_726_MOESM10_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent 1.4M Feb  1 10:44 12870_2016_726_MOESM10_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  37K Feb  1 10:44 12870_2016_726_MOESM12_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  18K Feb  1 10:44 12870_2016_726_MOESM13_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  20K Feb  1 10:44 12870_2016_726_MOESM14_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  17K Feb  1 10:44 12870_2016_726_MOESM15_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  16K Feb  1 10:44 12870_2016_726_MOESM16_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  17K Feb  1 10:44 12870_2016_726_MOESM17_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  30K Feb  1 10:44 12870_2016_726_MOESM18_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  15K Feb  1 10:44 12870_2016_726_MOESM19_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  25K Feb  1 10:44 12870_2016_726_MOESM19_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  13M Feb  1 10:44 12870_2016_726_MOESM1_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent 4.6M Feb  1 10:44 12870_2016_726_MOESM1_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  18K Feb  1 10:44 12870_2016_726_MOESM2_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  34K Feb  1 10:44 12870_2016_726_MOESM2_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  15K Feb  1 10:44 12870_2016_726_MOESM3_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  34K Feb  1 10:44 12870_2016_726_MOESM3_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent 1.9M Feb  1 10:44 12870_2016_726_MOESM4_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent 386K Feb  1 10:44 GSM1388555_WT_0.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent 385K Feb  1 10:44 GSM1388556_WT_1.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent 385K Feb  1 10:44 GSM1388557_WT_8.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent  729 Feb  1 10:44 README.md
> >
> >$ # Trier les fichiers par taille du plus volumineux au moins volumineux
> >$ ls -lh | sort -rh -k 5
> >-rw-rw-r-- 1 laurent laurent  13M Feb  1 10:44 12870_2016_726_MOESM1_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent 4.6M Feb  1 10:44 12870_2016_726_MOESM1_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent 1.9M Feb  1 10:44 12870_2016_726_MOESM4_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent 1.6M Feb  1 10:44 12870_2016_726_MOESM10_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent 1.4M Feb  1 10:44 12870_2016_726_MOESM10_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent 386K Feb  1 10:44 GSM1388555_WT_0.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent 385K Feb  1 10:44 GSM1388557_WT_8.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent 385K Feb  1 10:44 GSM1388556_WT_1.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent  37K Feb  1 10:44 12870_2016_726_MOESM12_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  34K Feb  1 10:44 12870_2016_726_MOESM3_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  34K Feb  1 10:44 12870_2016_726_MOESM2_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  30K Feb  1 10:44 12870_2016_726_MOESM18_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  25K Feb  1 10:44 12870_2016_726_MOESM19_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  20K Feb  1 10:44 12870_2016_726_MOESM14_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  18K Feb  1 10:44 12870_2016_726_MOESM2_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  18K Feb  1 10:44 12870_2016_726_MOESM13_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  17K Feb  1 10:44 12870_2016_726_MOESM17_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  17K Feb  1 10:44 12870_2016_726_MOESM15_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  16K Feb  1 10:44 12870_2016_726_MOESM16_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  15K Feb  1 10:44 12870_2016_726_MOESM3_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  15K Feb  1 10:44 12870_2016_726_MOESM19_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  729 Feb  1 10:44 README.md
> >total 24M
{:.answer}

Pour connaître la quantité d'espace disque occupée par un dossier, utiliser
la commande `du`, encore une fois avec l'option `-h`.

**Question 11**: Afficher la taille des sous-dossiers du dossier `study-cases`.
Comment faire pour ne pas tenir compte du dossier `.git` ?

> **Solution**:
> > # Taille des sous-dossiers du dossier study-cases
> > $ du -h
> > 8.0K    ./img
> > 756K    ./Homo_sapiens/TCGA_study-case
> > 760K    ./Homo_sapiens
> > 236K    ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq
> > 144K    ./Escherichia_coli/bacterial-regulons_myers_2013/data/RNA-seq
> > 384K    ./Escherichia_coli/bacterial-regulons_myers_2013/data
> > 1.1M    ./Escherichia_coli/bacterial-regulons_myers_2013
> > 8.0K    ./Escherichia_coli/genome-sequence_allue-guardia_2019
> > 736K    ./Escherichia_coli/genome-metabolome_fuhrer_2017
> > 1.9M    ./Escherichia_coli
> > 4.0K    ./.git/branches
> > 8.0K    ./.git/logs/refs/remotes/origin
> > 12      ./.git/logs/refs/remotes
> > 8.0K    ./.git/logs/refs/heads
> > 24K     ./.git/logs/refs
> > 32K     ./.git/logs
> > 8.0K    ./.git/info
> > 8.0K    ./.git/refs/remotes/origin
> > 12K     ./.git/refs/remotes
> > 8.0K    ./.git/refs/heads
> > 4.0K    ./.git/refs/tags
> > 28K      ./.git/refs
> > 44K      ./.git/hooks
> > 4.0K     ./.git/objects/info
> > 19M      ./.git/objects/pack
> > 19M      ./.git/objects
> > 20M      ./.git
> > 580K     ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables
> > 2.5M     ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017
> > 24M      ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016
> > 27M      ./Arabidopsis_thaliana
> > 49M
> > 
> > # Ne pas tenir compte du dossier .git
> > $ du -h --exclude .git
> > 8.0K    ./img
> > 756K    ./Homo_sapiens/TCGA_study-case
> > 760K    ./Homo_sapiens
> > 236K    ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq
> > 144K    ./Escherichia_coli/bacterial-regulons_myers_2013/data/RNA-seq
> > 384K    ./Escherichia_coli/bacterial-regulons_myers_2013/data
> > 1.1M    ./Escherichia_coli/bacterial-regulons_myers_2013
> > 8.0K    ./Escherichia_coli/genome-sequence_allue-guardia_2019
> > 736K    ./Escherichia_coli/genome-metabolome_fuhrer_2017
> > 1.9M    ./Escherichia_coli
> > 580K    ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables
> > 2.5M    ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017
> > 24M     ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016
> > 27M     ./Arabidopsis_thaliana
> > 30M .
{:.answer}


## Trouver les fichiers/dossiers omment trouver les fichiers volumineux sur un disque

L'option `-a` de la commande `du` permet d'affichier la taille des fichiers en plus
de celle des dossiers.
Associée à la commande `sort` et à la commande `head`, on peut ainsi rapidement
trouver les fichiers et dossier les plus volumineux.

```bash
$ du -ah --exclude .git | sort -rh | head
30M     .
27M     ./Arabidopsis_thaliana
24M     ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016
13M     ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
4.6M    ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.xlsx
2.5M    ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017
2.0M    ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/data sheet 1.pdf
1.9M    ./Escherichia_coli
1.9M    ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM4_ESM.xlsx
1.6M    ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.tsv
```

Noter également que `find -size` permet de trouver les fichiers en fonction de
leur taille :

```bash
# Trouver les fichiers de plus de 1M
$ find . -size +1M
./.git/objects/pack/pack-ebb930741581bed736361ee821e968dc10c0abef.pack
./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/data sheet 1.pdf
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.tsv
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.xlsx
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.xlsx
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM4_ESM.xlsx
```


## Réduire la quantité d'espace disque occupée par un fichier

Il s'agit de compresser un fichier.
Plusieurs outils de compression existent, le plus courant sous unix étant `gzip`
et l'outil de décompression associé `gunzip`.

**Question 12**: Quelle est la taille du fichier `./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv` ?
Le compresser avec `gzip`. Quelle est la taille du fichier compressé ?

> **Solution**:
> > $ # Taille du fichier ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
> > $ ls -lh ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
> > -rw-rw-r-- 1 laurent laurent 13M Feb  1 10:44 ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
> > $ # Le fichier fait 13M.
> > 
> > $ # Compression du fichier.
> > $ # Attention : par défaut, gzip compresse directement le fichier sans créer de copie
> > $ # On utilise l'option -c pour écrire la sortie sur la sortie standard et > pour rédiriger la sortie standard dans un fichier.
> > $ gzip -c ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv > ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv.gz
> > 
> > $ # Taille du fichier compressé
> > $ ls -lh ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv.gz
> > -rw-rw-r-- 1 laurent laurent 2.5M Feb  1 15:44 ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv.gz
> > $ # Le fichier fait 2.5M, soit un taux de compression de 80%.
{:.answer}

## Réduire le nombre de fichiers présents sur un disque et compression d'un dossier.

Réduire le nombre de fichiers présents sur un disque consiste à créer une *archive*
d'un dossier.
Cette archive va contenir, en un seul fichier, tous les fichiers présents initialement
dans le dossier.

### Création d'une archive

La commande pour créer une archive est `tar`.

**Syntaxe**: `tar cvf <TARNAME> <SOURCE>`.

`tar` est une commande un peu spéciale puisque certaines options sont accessibles
sans utiliser le caractère `-`.

Voici la signification des options utilisées :

- `c` mode création d'archive
- `f <OUTPUT>` nom du fichier de sortie

Il est également possible d'utiliser l'option `-z` (`tar czf`) pour compresser
l'archive à la volée.

**Exemple**:

```bash
$ # Création d'une archive pour le dossier Arabidopsis_thaliana
$ tar cf Arabidopsis_thaliana.tar Arabidopsis_thaliana

$ # Idem mais en compressant l'archive à la volée.
$ tar czf Arabidopsis_thaliana.tar.gz Arabidopsis_thaliana
```

On peut également utiliser l'option (`-v, --verbose`) pour afficher le nom des
fichiers au fur et à mesure qu'ils sont ajoutés à l'archive) :

```bash
$ # Idem mais en compressant l'archive à la volée.
$ tar cvzf Arabidopsis_thaliana.tar.gz Arabidopsis_thaliana
$ tar cvzf Arabidopsis_thaliana.tar.gz Arabidopsis_thaliana
Arabidopsis_thaliana/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S4 Root exudate proteome.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S4_Root_exudate_proteome.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S2 Root Exudates JL140617.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S3 Analytical Characterization.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S1_Roots.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S3_Analytical_Characterization.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S1 Roots.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S2_Root_Exudates_JL140617.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/README.md
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/data sheet 1.pdf
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM2_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM19_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM14_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/README.md
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM16_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM15_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM17_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM3_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388555_WT_0.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM12_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM13_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM18_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388557_WT_8.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM2_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388556_WT_1.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM4_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM19_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM3_ESM.xlsx
```

### Extraction d'une archive

On utilise également l'outil `tar` pour extraire le contenu d'une archive.

**Syntaxe**: `tar xvf <TARNAME> <SOURCE>`.

Ici, on utilise l'option `-x` (*extract*) à la place de l'option `-c` (*create*).
Si l'archive est compressée, on utilise l'option `-z` pour indique au programme
qu'il faudra décompresser l'archive.

**Exemple**:

```bash
# Extraction d'une archive compressée en mode verbeux (verbose)
$ tar xvzf ../Arabidopsis_thaliana.tar.gz
Arabidopsis_thaliana/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S4 Root exudate proteome.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S4_Root_exudate_proteome.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S2 Root Exudates JL140617.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S3 Analytical Characterization.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S1_Roots.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S3_Analytical_Characterization.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S1 Roots.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S2_Root_Exudates_JL140617.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/README.md
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/data sheet 1.pdf
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM2_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM19_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM14_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/README.md
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM16_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM15_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM17_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM3_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388555_WT_0.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM12_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM13_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM18_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388557_WT_8.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM2_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388556_WT_1.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM4_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM19_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM3_ESM.xlsx
```

