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


# Partie 2 : accéder et manipuler le contenu des fichiers

## cat

Affiche le contenu du ou des fichiers en arguments ou de l'entrée standart

## less

Lire le contenu du ou des fichiers en arguments en se déplacant écran par écran dans le (les fichiers)
Commandes utiles associées à less :

- 'barre d'espace' : faire défiler le contenu page par page

- ':n' : passe au fichier suivant ('next file', si plusieurs fichiers en arguments)

- ':p' : passe au fichier précédent ('previous file', si plusieurs fichiers en arguments)

- ':q' : quitte less

## head 

Affiche la première partie (10 lignes par défaut) de chacun des fichiers en arguments.

'head -n nom_fichier' : affiche les n premières lignes d'un fichier

## tail

Affiche la dernière partie (10 lignes par défaut) de chacun des fichiers en arguments.

'tail -n nom_fichier' : affiche les n dernières lignes d'un fichier

## grep

Affiche les lignes du ou des fichiers en argument correspondant à un 'motif' (ou contenu) donné en argument
(Abréviation de Get Regular Expression Print)

grep 'motif' fichier1 fichier2

Option utiles :

'-c' : signifie 'count'. Affiche uniquement le nombre de lignes contenant le motif

'-n' : affiche aussi le numéro de la ligne contenant le motif

'-v' : affiche les lignes qui ne contiennent pas le motif

## wc

Compte le nombre de lignes, mots et caractères du ou des fichiers donnés en arguments

'-l' : uniquement le nombre de lignes

'-w' : uniquement le nombre de mots

'-c' : uniquement le nombre de caractères

## sort

Trie les lignes du ou des fichiers donnés en argument
Attention : tri par défaut selon le code ASCII

'-n' : tri numérique

'-k num_colonne' : tri selon la colonne k du fichier

## cut

Extrait les colonnes de chacun des fichiers en argument

Par défaut une colonne est un caractère

'-d separateur' : spécifie le caractère 'separateur' qui sépare les colonnes à extraire

'-c liste de caracteres' : spécifie les caractères à extraire

'-f liste de champs' : spécifie les champs à extraire














