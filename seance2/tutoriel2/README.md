# Tutoriel 2 : connexion à un serveur distant, transfert de fichier

## Connexion à un serveur distant

Sous Unix, on utilise la commande `ssh` pour établir une communication sécurisée, 
sur un réseau informatique (Intranet ou Internet) entre une machine locale (le client) et une machine distante (le serveur).
La syntaxe de la commande est la suivante :

ssh <nom_utilisateur>@nom_serveur_distant

Question : Connectez-vous au serveur **core.cluster.france-bioinformatique.fr** en utilisant la commande `ssh`.

> **Solution :**:
> > ```bash
> > $ ssh hchiapello@core.cluster.france-bioinformatique.fr 
> > ```
{:.answer}

## Transfert - copie de fichiers - avec scp
Pour copier un fichier à partir d'un ordinateur sur un autre vous devrez utiliser la commande `scp`. 
La syntaxe est la suivante :

### Pour un fichier

scp monfichier.txt <nom_utilisateur>@<nom_serveur_distant>:<répertoire_destination>

Question : copier le fichier `Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3` dans votre  répertoire utilisateur ("home directory") du serveur core cluster de l'IFB :
> **Solution :**:
> > ```bash
> > $ scp Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 hchiapello@core.cluster.france-bioinformatique.fr:~/ 
> > ```
{:.answer}

### Pour un répertoire :

scp -r monrépertoire <nom_utilisateur>@<nom_serveur_distant>:<répertoire_destination>

Exemple : 

Exercice :

Transférez le répertoire X de votre machine locale vers le serveur core.cluster.france-bioinformatique.fr dans votre répertoire utilisateur par défaut ("home")

## Synchronisation de contenus avec rsync

## A voir : commade wget pour récupérer par exemple un génome du NCBI ?

