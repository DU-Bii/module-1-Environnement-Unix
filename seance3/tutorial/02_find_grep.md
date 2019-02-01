# Partie 2 : Recherche de fichiers ou de contenus

## Recherche de fichier : find

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

**Question 2 : rechercher toutes les occurences du gène 'oriC' en affichant le
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

Suite : [Extraction des données d'un fichier et gestion de flux](03_extraction_donnees_et_pipes.md)