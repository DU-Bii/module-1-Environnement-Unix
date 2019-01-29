# Partie 1 : Révision et consolidation des deux séances précédentes 
- **Arborescence Linux** : fichiers, répertoires,etc...
- **Contenu d'un fichier** : savoir affichier le contenu d'un fichier et travailler avec l'éditeur **nano**
- **Commandes Linux** : aide sur une commande, historique et répétiton des commandes. Redirection des entrées, sorties et erreurs standarts.
- **Accès aux ressources de cluster NNCR** : savoir accéder et utiliser les ressources du cluster NNCR. Savoir transférer ses données dans un répertoire ad-hoc, savoir organiser ses fichiers et répertoires (bonnes pratiques en bioinfo)

# Partie 2 : Recherche de fichiers ou de contenus  

## find  

La commande `find` permet de rechercher des fichiers de manière récursive dans un chemin à partir d'un motif  
Un motif est ici une expression ou une chaine de caractères correspondant au nom ou une partie du nom du fichier recherché  
**Syntaxe : find [chemin] -name "motif"**  

**Question 1 : Rechercher dans votre répertoire study-cases tous les fichiers au format bed (i.e. dont l'extension est ".bed")**   

> **Solution :**: 
> > ```bash
> > $ $ find ~/DUBii/study-cases -name "*.bed" 
> > ~/DUBii/study-cases/Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed
> > ~/DUBii/study-cases/Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
> > ```
{:.answer}

## grep  

La commande `grep` permet de rechercher et afficher les lignes contenant un motif donné en argument dans un ou des fichiers donnés en argument  
Un motif est ici une expression ou une chaine de caractères correspondant à l'élément recherché (un nom de gène, de protéine,...etc)  
**Syntaxe : grep [options] motif FICHIERS**  
La commande grep a beaucoup d'options très utiles, par exemple :  
- `-i` : ignore les distinctions de casse dans le motif
- `-v`: sélectionne les lignes NE contenant PAS le motif
- `-n`: préfixe chaque ligne de sortie avec son numéro de ligne
- `-c`: affiche uniquement le nombre total de lignes contenant le motif  

**Question 2 : Rechercher toutes les occurences du gène 'oriC' en affichant le numéro de ligne de chaque occurence dans le fichier Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3**

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

# Partie 2  : Extraction des données d'un fichier et gestion de flux

## cut  

La commande `cut` permet d'extraire une ou plusieurs colonnes d'un fichier de différentes manières  
La commande peut prendre en argument
- soit *les positions des caractères* dans le fichier (cad dire les numéro colonnes)  
Dans ce cas on spécifiera les positions des colonnes à extraire avec l'option `-c`  
Exemple : `cut -c 1-10 toto.csv`  

- soit *les positions des champs (fields)* dans le fichier (cad dire les numéro des champs). Le délimitateur par défaut est la tabulation, on peut le changer avec l'option `-d`
Exemple : `cut -d "," -f 2 toto.csv`  

**Question 3 : Extraire de deux manières différentes la colonne Geneid du fichier cutadapt_bwa_featureCounts_all.tsv*

> **Solution :**: 
> > ```bash
> > $ cut -f 1 cutadapt_bwa_featureCounts_all.tsv 
> > $ cut -c 1-6 cutadapt_bwa_featureCounts_all.tsv
> >  
> > ```
{:.answer}

## sort  

La commande `sort` permet de trier les lignes du ou des fichiers donnés en argument  
Attention le tri par défaut est selon le code ASCII et pas selon l'ordre numérique. Pour faire un tri numérique utiliser l'option `-n` 

**Question 4 : Extraire la 2ème colonne 'WT1' du fichier cutadapt_bwa_featureCounts_all.tsv rediriger le résultat dans un fichier de sortie 'cutadapt_bwa_featureCounts_WT1.tsv'. Trier ensuite les valeurs de ce fichier par ordre croissant.  
> **Solution :**: 
> > ```bash  
> > cut -f 2  cutadapt_bwa_featureCounts_all.tsv  > cutadapt_bwa_featureCounts_WT1.tsv
> > sort -n cutadapt_bwa_featureCounts_WT1.tsv
> >  
> > ```
{:.answer}

## uniq  


## wc  
## Enchainement de commandes avec |


# Partie 3 : Notions sur les expressions régulières
## les expressions de bases
## quelques sites de vérification des expressions régulières
## utilisation basique de sed
# Partie 4 : Espace de stockage, compression et archivage de données
## Gérer son espace disque : les commandes du et df
## Archiver avec tar
## gzip, gunzip
## Application des mêmes commandes sur des gros fichiers compressés (zless, zgrep, zcat)

