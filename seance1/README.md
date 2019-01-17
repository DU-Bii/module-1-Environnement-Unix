# Partie 1 : les fichiers et les répertoires
## Révisions du prérequis module1 du Datacamp
- *Répertoire* : savoir afficher le répertoire courant, afficher le contenu d'un répertoire, changer de répertoire, créer un répertoire
- *Aborescence Linux* : maitriser la notion de chemin absolu et relatif, connaitre les répertoires particuliers de l'arborescence Linux, savoir afficher l'arborescence Linux
- *Fichiers* : savoir copier, supprimer, déplacer un fichier
# Partie 2 : manipuler le contenu des fichiers
## Préparer les données
### Connexion sur le cluster NNCR en ssh avec vos comptes personnels
commande à venir
### Créer un réprtoire DUBii et se positionner dans ce répertoire
`mkdir DUBii`
`cd DUBii`
## Télécharger les fichiers des jeux de données du DUBii 
Utiliser la commande suivante : 
`git clone https://github.com/DU-Bii/study-cases.git`
Se positionner dans le répertoire study-cases
`cd study-cases`
Utiliser la commande `tree` pour visualiser l'arborescence
`tree`
Se positionner dans le répertoire Escherichia_coli/bacterial-regulons_myers_2013/data
`cd Escherichia_coli/bacterial-regulons_myers_2013/data`
## Afficher le contenu d'un fichier
Sous Linux on dispose de plusieurs commandes permettant d'afficher le contenu de fichiers texte de différentes manières
### Afficher le contenu entier du fichier
#### cat
Affiche et concaténe le contenu du ou des fichiers donnés en arguments (ou de l'entrée standart) sur la sortie standart
Exemple 1 : affichier le contenu du fichier cutadapt_bwa_featureCounts_all.tsv dans le répertoire data/RNA-seq
`$ cat data/RNA-seq/cutadapt_bwa_featureCounts_all.tsv`
Exemple 2 : concaténer le contenu des fichiers FNR1_vs_input1_cutadapt_bowtie2_homer.bed et FNR1_vs_input1_cutadapt_bowtie2_macs2.bed dans le répertoire data/ChIP-seq
`cat data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_macs2.bed`
*Question* : quel incopnvénient majeur voyez-vous à la commande `cat`?
#### more and less
Les deux commandes `more` et `less` vous permettent d'afficher le contenu d'un ou plusieurs fichiers page par page, ce qui est très utile lorsqu'on manipule des fichiers de taille importante
La commande `less` est une évolution récente de `more` avec plus de fonctionnalités
Options utiles
- 'barre d'espace' : faire défiler le contenu page par page
- '/' : permet de tropuver les occurences d'un motif
- ':n' : passe au fichier suivant ('next file', si plusieurs fichiers en arguments)
- ':p' : passe au fichier précédent ('previous file', si plusieurs fichiers en arguments)
- ':q' : quitte less
Afficher le contenu du fichier ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed avec less
% serait plus intéressant d'avoir un fichier gff
#### head

#### tail
