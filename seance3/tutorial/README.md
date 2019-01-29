# Partie 1 : Révision et consolidation des deux séances précédentes 
- **Arborescence Linux** : fichiers, répertoires,etc...
- **Contenu d'un fichier** : savoir affichier le contenu d'un fichier et travailler avec l'éditeur **nano**
- **Commandes Linux** : aide sur une commande, historique et répétiton des commandes. Redirection des entrées, sorties et erreurs standarts.
- **Accès aux ressources de cluster NNCR** : savoir accéder et utiliser les ressources du cluster NNCR. Savoir transférer ses données dans un répertoire ad-hoc, savoir organiser ses fichiers et répertoires (bonnes pratiques en bioinfo)
# Partie 2 : Recherche de fichiers ou de contenus  
## find  
Rechercher des fichiers dans une chemin à partir d'un motif 
Un motif est une expression ou une chaine de caractères correspondant au nom ou une partie du nom du fichier recherché  
**Syntaxe :** find [chemin] -name "motif" 
**Question 1 : Rechercher dans votre répertoire study-cases tous les fichiers au format bed (i.e. dont l'extension est ".bed")**      
> **Solution**: 
> > ```bash
> > $ $ find ~/DUBii/study-cases -name "*.bed" 
> > ~/DUBii/study-cases/Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed
> > ~/DUBii/study-cases/Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
> > ```
{:.answer}

# Partie 2  : Extraction des données d'un fichier et gestion de flux
## grep  
## cut  
## sort  
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

