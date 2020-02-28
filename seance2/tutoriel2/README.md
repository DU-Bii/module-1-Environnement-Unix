# Tutoriel 2 : connexion à un serveur distant, transfert de fichier

## Connexion à un serveur distant

Sous Unix, on utilise la commande `ssh` pour établir une communication sécurisée, 
sur un réseau informatique (intranet ou Internet) entre une machine locale (le client) et une machine distante (le serveur)
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

Exemple :

### Pour un répertoire :

scp -r monrépertoire <nom_utilisateur>@<nom_serveur_distant>:<répertoire_destination>

Exemple : 


Transférez le fichier X de votre machine locale vers le serveur core.cluster.france-bioinformatique.fr dans votre répertoire utilisateur par défaut ("home")

## Synchronisation de contenus avec rsync

