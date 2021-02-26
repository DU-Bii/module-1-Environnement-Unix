# Partie 2.4 : connexion à un serveur distant, transfert de fichier

## Connexion à un serveur distant

Jusqu'à maintenant vous travailliez à distance sur les serveurs de l'infrastructure IFB en utilisant un logiciel dédié dans un navigateur web pour vous connecter : **JupyterHub**. 
Ce logiciel n'est pas disponible sur toutes les plateformes bioinformatiques. Nous vous proposons donc de vous familiariser avec la commande `ssh` qui vous permettra d'accéder à un **serveur Unix distant depuis un *terminal* de votre ordinateur local**. Cette commande est disponible sur la plupart des ordinateurs sius Unix et vous permettra d'accéder à tout serveur Unix distant autorisant les connexions depuis Internet, donc à la plupart des plateformes bioinformatiques de l'IFB.

Sous Unix, la commande `ssh` permet ainsi d' établir une communication sécurisée, 
sur un réseau informatique (Intranet ou Internet) entre une machine locale (le client) et une machine distante (le serveur).
La syntaxe de la commande est la suivante :

`ssh <nom_utilisateur>@<nom_serveur_distant>`


Exercice : Connectez-vous au serveur **core.cluster.france-bioinformatique.fr** depuis un **terminal** de votre poste de travail local Linux en utilisant la commande `ssh`.

> **Solution :**:
> > ```bash
> > $ ssh hchiapello@core.cluster.france-bioinformatique.fr 
> > ```
{:.answer}

## Transfert - copie de fichiers - avec scp
Pour copier un fichier à partir d'un ordinateur sur un autre vous devrez utiliser la commande `scp`. 
La syntaxe est la suivante :

### Pour un fichier

`scp monfichier.txt <nom_utilisateur>@<nom_serveur_distant>:<répertoire_destination>`

Question : copier le fichier `~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3` dans votre  répertoire utilisateur ("*home directory*") du serveur core cluster de l'IFB :
> **Solution :**:
> > ```bash
> > $ scp Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3 hchiapello@core.cluster.france-bioinformatique.fr:~/ 
> > ```
{:.answer}

### Pour un répertoire :

`scp -r monrépertoire <nom_utilisateur>@<nom_serveur_distant>:<répertoire_destination>`


Question : Transférer le répertoire study-cases/Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq de votre machine locale vers le serveur core.cluster.france-bioinformatique.fr dans votre répertoire utilisateur par défaut ("home directory")

> **Solution :**:
> > ```bash
> > $ scp -r study-cases/Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq hchiapello@core.cluster.france-bioinformatique.fr:~/
> > ```
{:.answer}

## Si vous voulez aller plus loin

D'autres commandes vous permettent de transférer des fichiers de données stockés sur une serveur distant, par exemple :  `wget`, `rsync`, `curl`,...

Exercice :  récupérer un génome Refseq de votre choix sur le site du NCBI avec une des commandes proposées dans 
la documentation  : https://www.ncbi.nlm.nih.gov/genome/doc/ftpfaq/ 

