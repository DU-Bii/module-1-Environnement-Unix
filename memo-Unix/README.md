# Mémo Unix

Principales commandes Unix

# Partie 1 : les fichiers et les répertoires

## cd

Change de répertoire courant. L'utilisateur se déplace dans un autre répertoire.

`cd` est l'acronyme pour *change directory*.

Exemple :
```
$ cd test
```
L'utilisateur se déplace dans le répertoire `test`.


#### Notion de chemin relatif et absolu

En Unix, on distingue le chemin absolu et le chemin relatif. Le chemin absolu commence par le caractère `/` alors que ce n'est pas le cas pour le chemin relatif. Par exemple, `/home/pierre` est un chemin absolu et `documents/TP/` est un chemin relatif. Remarquez que le caractère `/` sert aussi à séparer les différents répertoires et sous-répertoires entre eux.

#### Raccourcis pour les chemins

`.` désigne le répertoire courant.

`..` désigne le répertoire parent. Par exemple si l'utilisateur est dans le répertoire `/home/pierre`, alors après avoir exécuté la commande `cd ..`, il se trouvera dans le répertoire `/home`

`~` désigne le répertoire utilisateur. Par exemple `~/documents` désigne le répertoire `documents` du répertoire utilisateur. Si le répertoire utilisateur est `/home/pierre`, alors `~/documents` est équivalent à `/home/pierre/documents`.


## pwd

Affiche le répertoire courant, celui dans lequel l'utilisateur se trouve actuellement.

`pwd` est l'acronyme pour *print working directory*.

Exemple :
```
$ pwd
/home/pierre
```
Ici le répertoire courant est `/home/pierre`, c'est-à-dire le répertoire personnel de l'utilisateur `pierre`.

## ls

Affiche le contenu d'un répertoire
Sans argument affiche les fichiers et répertoires du répertoire courant
(Avec argument affiche les les fichiers et répertoires du chemin du répertoire donné en argument)

Exemple :
```
$ ls
seq1.fsa  seq2.fsa
```
Le répertoire courant contient 2 fichiers : seq1.fsa et seq2.fsa

## cp 

Signifie 'copy'. Copie un fichier : cp fichier_source fichier_copie

## mv

Signifie 'move'. Déplace (et éventuellement renomme) un fichier ou répertoire  : mv source destination

## mkdir

Signifie 'make directory'. Crée un nouveau répertoire : mkdir chemin

## rmdir

Signfie 'remove directory'. Supprime un répertoire : rmdir chemin

## rm

Signifie 'remove'. Supprime un fichier : rmdir fichier



