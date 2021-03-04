# Partie 2.4 : connexion à un serveur distant, transfert de fichier

## Objectifs

- Apprendre à se connecter à une machine distante
- Apprendre à transférer des données vers/depuis une machine distante

## Connexion à un serveur distant avec `ssh`

Jusqu'à maintenant vous travailliez à distance sur les serveurs de l'infrastructure IFB en utilisant un logiciel dédié dans un navigateur web pour vous connecter : **JupyterHub**. 
Ce logiciel n'est pas disponible sur toutes les plateformes bioinformatiques. Nous vous proposons donc de vous familiariser avec la commande `ssh` qui vous permettra d'accéder à un **serveur Unix distant depuis un *terminal* de votre ordinateur local**. Cette commande est disponible sur la plupart des ordinateurs sous Unix et vous permettra d'accéder à tout serveur Unix distant autorisant les connexions depuis Internet, donc à la plupart des plateformes bioinformatiques de l'IFB.

### Connexion au cluster de calcul de l'IFB depuis un poste de travail sous Linux, Mac OS X et WSL

Si vous travaillez avec les systèmes d'exploitations Linux (Ubuntu, Mint, Debian...), Mac OS X ou WSL pour Windows 10, vous avez déjà un *shell* installé sur votre machine. 

Avec ce *shell*, vous trouverez également la commande `ssh` qui permet de se connecter à un serveur distant.

### Connexion au cluster de calcul de l'IFB depuis Windows (hors WSL)


Si vous souhaitez simplement un logiciel sous Windows pour vous connecter au cluster du NNCR en SSH. Nous vous conseillons [MobaXterm](https://mobaxterm.mobatek.net/). La version [*Free*](https://mobaxterm.mobatek.net/download.html) est suffisante. Vous trouverez quelques vidéos de démo [ici](https://mobaxterm.mobatek.net/demo.html).

### Syntaxe de la commande ssh

Sous Unix, la commande `ssh` permet d'établir une communication sécurisée entre une machine locale (le client) et une machine distante (le serveur).
La syntaxe de la commande est la suivante :

`ssh <nom_utilisateur>@<nom_serveur_distant>`


**Exercice 1**  
Ouvrez un  **terminal** sur votre poste de travail local Linux et connectez-vous au serveur **core.cluster.france-bioinformatique.fr** depuis ce **terminal** en utilisant la commande `ssh`.

> **Solution :**
> > ```bash
> > $ ssh hchiapello@core.cluster.france-bioinformatique.fr 
> > ```
{:.answer}

## Transfert - copie de fichiers - avec `scp`
Pour copier un fichier à partir d'un ordinateur sur un autre vous devrez utiliser la commande `scp`. 
La syntaxe est la suivante :

### Pour un fichier

`scp monfichier.txt <nom_utilisateur>@<nom_serveur_distant>:<répertoire_destination>`

**Exercice 2**  
- Ouvrez un deuxième **terminal** sur votre poste de travail local Linux 
- Créez un répertoire `test` sur votre poste de travail local 
- Se déplacer dans le répertoire `test` et créer un fichier sur votre poste de travail local `motif_adn.fna` au format fasta (une première ligne avec d'entête content `>motif` et une deuxième ligne avec la séquence nucleotidique `ATCGGGCATAGGGAGGGCATATATATAAGCACACC`. Vous pourrez par exemple utiliser pour cela l'éditeur de texte `nano`. 
- Copier ce fichier `motif_adn.fna` sur le serveur distant core cluster de l'IFB dans le répertoire `~/dubii/` de votre répertoire utilisateur ("*home directory*") :
> **Solution :**:
> > ```bash
> > $ mkdir test
> > $ cd test
> > $ nano ./motif_adn.fna
> > $ scp motif_adn.fna hchiapello@core.cluster.france-bioinformatique.fr:~/dubii/ 
> > ```
{:.answer}

### Pour un répertoire :

`scp -r monrépertoire <nom_utilisateur>@<nom_serveur_distant>:<répertoire_destination>`


**Exercice 3**
- **Sur votre terminal local**, remplacer toutes les occurences de `T` par `U` dans le fichier `motif_adn.fna` en utilisant la commande `sed` et rediriger le résultat dans un fichier nommé `motif_arn.fna`
- Copier le répertoire `test` et son contenu sur le serveur distant core cluster de l'IFB dans le répertoire `~/dubii/` de votre répertoire utilisateur ("*home directory*") :

> **Solution :**
> > ```bash
> > $ sed 's/T/U/g' motif_adn.fna > motif_arn.fna
> > $ cd ..
> > $ scp -r ./test hchiapello@core.cluster.france-bioinformatique.fr:~/dubii/
> > ```
{:.answer}

## Si vous voulez aller plus loin

D'autres commandes vous permettent de transférer des fichiers de données stockés sur une serveur distant, par exemple :  `wget`, `rsync`, `curl`,...

Exercice :  copier dans votre répertoire test local un génome Refseq de votre choix depuis le site du NCBI avec une des commandes proposées dans 
la documentation  : https://www.ncbi.nlm.nih.gov/genome/doc/ftpfaq/ 

