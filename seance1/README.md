# Partie 1 : les fichiers et les répertoires

## Révisions du prérequis module1 du Datacamp
- **Répertoires** : savoir afficher le répertoire courant, afficher le contenu d'un répertoire, changer de répertoire, créer un répertoire
- **Aborescence Linux** : maitriser la notion de chemin absolu et relatif, connaitre les répertoires particuliers de l'arborescence Linux, savoir afficher l'arborescence Linux
- **Fichiers** : savoir copier, supprimer, déplacer un fichier. Savoir nommer un fichier avec une extension adéquate. Connaitre les caractères spéciaux (* et ?)


---

**Question**: this is a test question.

> **Solution**:
> > This is the test solution to the test question
> > ```bash
> > $ echo "so much information here"
> > ```
> Interesting, isn't it?
{:.answer}

---


**Question 1** : préparer les données pour les exercices


### Connexion sur le cluster NNCR en ssh avec vos comptes personnels
%commande à venir  
%sinon travail en local sur les postes de la salle  

### Créer un répertoire DUBii et se positionner dans ce répertoire

```bash
$ mkdir DUBii
$ cd DUBii
```


### Télécharger les fichiers des jeux de données du DUBii 

```bash
$ # Récupération du répertoire avec git
$ git clone https://github.com/DU-Bii/study-cases.git
$ # Se positionner dans le répertoire study-cases
$ cd study-cases
$ # Utiliser la commande `tree` pour visualiser l'arborescence
$ tree
[...]
$ # Se positionner dans le répertoire Escherichia_coli/bacterial-regulons_myers_2013
$ cd Escherichia_coli/bacterial-regulons_myers_2013
```

  
# Partie 2 : Afficher le contenu d'un fichier

Sous Linux on dispose de plusieurs commandes permettant d'afficher le contenu de fichiers texte de différentes manières.

## cat

Affiche et concatène le contenu du ou des fichiers donnés en arguments (ou de l'entrée standard) sur la sortie standard
**Exemple 1**: afficher le contenu du fichier `cutadapt_bwa_featureCounts_all.tsv` dans le `répertoire data/RNA-seq`

> Solution:
> > ```bash
> > $ cat data/RNA-seq/cutadapt_bwa_featureCounts_all.tsv
> > Geneid  WT1 WT2 dFNR1   dFNR2
> > b0001   70  98  72  63
> > b0002   23421   33092   32156   20749
> > b0003   7538    10350   9596    6490
> > b0004   8263    11927   11042   7145
> > b0005   121 156 104 62
> > b0006   177 224 287 209
> > b0007   138 116 68  50
> > b0008   2964    3971    4211    2823
> > b0009   213 205 196 128
> > [...]
> > b4400   82  42  37  35
> > b4401   3349    4692    2619    1609
> > b4402   201 318 224 128
> > b4403   82  116 87  68
> > ```
{:.answer}


**Exemple 2** : concaténer le contenu des fichiers `FNR1_vs_input1_cutadapt_bowtie2_homer.bed`
et `FNR1_vs_input1_cutadapt_bowtie2_macs2.bed` dans le répertoire `data/ChIP-seq`.

> Solution:
> > ```bash
> > $ cat data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed data/ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
> > # HOMER Peaks
> > # Peak finding parameters:
> > # tag directory = ChIP-seq/results/peaks/FNR1_vs_input1/homer/FNR1_tag
> > #
> > # total peaks = 161
> > # peak size = 177
> > # peaks found using tags on both strands
> > # minimum distance between peaks = 354
> > # fragment length = 176
> > # genome size = 4639221
> > [...]
> > Chromosome  4628694 4628894 FNR1_vs_input1_cutadapt_bowtie2_macs2_peak_409  255 .   1.64016 27.14359    25.51793    45
> > Chromosome  4633063 4633362 FNR1_vs_input1_cutadapt_bowtie2_macs2_peak_410  374 .   1.87671 39.12086    37.41762    131
> > Chromosome  4640075 4640748 FNR1_vs_input1_cutadapt_bowtie2_macs2_peak_411  6432    .   4.90760 645.83362   643.22699   454
> > ```
{:.answer}

  
**Question 2** : quel inconvénient majeur voyez-vous à la commande `cat`?  

> **Réponse**: 
> > La commande `cat` affiche la totalité des fichiers ce qui rend la sortie
> > de la commande souvent illisible.
{:.answer}


## more & less

Les deux commandes `more` et `less` vous permettent d'afficher le contenu d'un ou plusieurs fichiers page par page, ce qui est très utile lorsqu'on manipule des fichiers de taille importante  
La commande `less` est une évolution récente de `more` avec plus de fonctionnalités  
Options utiles  
- 'barre d'espace' : faire défiler le contenu page par page  
- '/' : permet de tropuver les occurences d'un motif  
- ':n' : passe au fichier suivant ('next file', si plusieurs fichiers en arguments)  
- ':p' : passe au fichier précédent ('previous file', si plusieurs fichiers en arguments) 
- ':q' : quitte less  
  
**Question 3** : Afficher le contenu du fichier ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed avec less  
% serait plus intéressant d'avoir un fichier gff
  
## head
La commande `head`permet d'afficher uniquement le début du ou des fichiers(s) donnés en argument  
Par défaut head affiche les 10 premières lignes d'un fichier  
Utiliser l'option '-n N' pour afficher les N premières lignes d'un fichier 
  
**Question 4** : Afficher les 20 premières lignes du fichier ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed avec head
  
## tail
La commande `tail`permet d'afficher uniquement la fin du ou des fichiers(s) donnés en argument  
Par défaut head affiche les 10 dernières lignes d'un fichier  
Utiliser l'option '-n N' pour afficher les N dernières lignes d'un fichier  
  
**Question 5** : Afficher les 20 dernières lignes du fichier ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed avec tail 
  
## L'éditeur de texte nano
Il existe beaucoup d'éditeurs de fichiers textes sour Linux  
Parmi les plus connus on trouve : vi, emacs et nano.  
Nano est l'éditeur le plus simple à utiliser.  
  
**Question 6** : qu'est-ce qu'un un éditeur de texte ? Quelle différence avec un traitement de texte ?  
Réponse : éditeur = programme permettant de modifier des fichiers texte sans mise en forme, traitement de texte = logiciel le plus souvent avec une interface graphique pour mettre en forme des documents.  
  
Pour lancer l'éditeur de texte nano : il vous suffit de taper `nano`éventuellement suivi d'un nom de fichier à éditer  
Toutes les commandes sont résumées dans le bandeau en bas de l'écran  
Le symbole ^ signifie Ctrl (la touche Contrôle de votre clavier).  
Voici les raccourcis les plus importants :
Ctrl-G : afficher l'aide ;  
Ctrl-K : couper la ligne de texte (et la mettre dans le presse-papier) ;  
Ctrl-U : coller la ligne de texte que vous venez de couper ;  
Ctrl-C : afficher à quel endroit du fichier votre curseur est positionné (numéro de ligne) ;  
Ctrl-W : rechercher une chaine de caractères dans le fichier ;  
Ctrl-O : enregistrer le fichier (écrire) ;  
Ctrl-X : quitter Nano.  
Vous pouvez vous déplacer dans le fichier avec les flèches du clavier ainsi qu'avec les touches Page Up et Page Down pour avancer de page en page (les raccourcis Ctrl-Y et Ctrl-V fonctionnent aussi).  
  
**Question 7** : ouvrir avec l'éditeur nano le fichier xxx.gff
  
Recherche les lignes contenant le mot x  
Supprimer ces lignes  
Enregistrer le fichier sous le nom xxx_v2.gff  
Remarques : 
- pour rechercher un mot plusieurs fois sans le réécrire, tapez juste `Entrée`  
- si vous voulez sortir du mode recherche, tapez `Ctrl-C`  
# Partie 3 : les commandes Linux : aide, répétition, redirection
## Avoir de l'aide sur une commande 
Sous Linux toutes les commandes sont documentées de manières standardisée  
Il y a deux moyens d'accèder à l'aide d'une commande :  
- via la commande `help nom_commande` qui permet d'accéder au manuel (description complète) de la commande page par page avec les facilités de recherche d'un éditeur de texte  
- via l'option `nom de commande --help`: on affiche l'ensemble de la documentation et des options à l'écran  
  
**Question 8** : Quelle signifie l'option '-N' de la commande less ?
  
## Répéter une commande : notion d'historique 
Le système d'exploitation Linux garde en mémoire les commandes lancées par un utilisateur dans un terminal. la liste des commandes lancées par un utilisatur est accessible via la commande `history`. Selon les systèmes il est possible d'accéder aux 500 ou 1000 dernières commandes.  
Il est aussi possible de retrouver une commande en utilisant la commande `!`  
Par exemple la commande `!?expression?` permet de relancer la dernière commande utilisée contenant le mot 'expression'  
La commande `!grep` permet de relancer la dernière commande utilisée comemnçant par 'grep' 
  
**Question 9** : que fait la commande `!n -3` ?  
  
## Sauver le résultat d'une commande Linux dans un fichier : notion de redirection
La possibilité de redirection de l'entrée ou de la sortie standard est une notion fondamentale du système d'exploitation Linux.  
Par défaut tout programme Linux a trois flots de direction   
- une **entrée standard**, appelée 'stdin', par défaut associée au **clavier**  
- une **sortie standard**, appelée 'stdout', par défaut associée à **l'écran**  
- une **erreur standard** appelée 'stderr', par défaut associée à **l'écran**  
Une redirection est une modification de l’une de ces associations. Elle est valable uniquement le temps de la commande sur laquelle elle porte.  
Pour modifier l'entrée standard d'une commande en lisant les données d'un fichier 'infile' on utilise : 
`< infile`  
Pour modifier la sortie standard d'une commande et écrire les résultats dans un fichier 'outfile' on utilise : 
`> outfile` ou `>> outfile`  
Pour modifier l'erreur standard d'une commande et écrire les messages d'erreurs dans un fichier 'errfile' on utilise :
`2> errfile`  
En résumé tout programme Linux peut s'écrire  
`$program < infile > outfile 2> errfile`  
  
**Question 10**: rediriger le résultat de la commande 'cat' sur le fichier ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed dans le fichier 'test.txt'. Que contient le fichier 'test.txt' ?  





