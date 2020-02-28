# Objectifs

- **Répertoires** : Afficher le répertoire courant. Afficher le contenu d'un répertoire. Changer de répertoire. Créer, déplacer et supprimer un répertoire.
- **Aborescence Linux** : Distinguer la notion de chemin absolu et relatif. Utiliser les raccourcis de l'arborescence Linux (`.`, `..`, `~`). Afficher l'arborescence Linux.
- **Fichiers** : Copier, supprimer et déplacer un fichier. Nommer un fichier avec une extension adéquate. Utiliser les caractères spéciaux (`*`, `?`). Afficher le contenu d'un fichier (complet, le début, la fin). Modifier un fichier avec un éditeur de texte.


# Partie 1 : les fichiers et les répertoires

Sur votre station de travail, dans un *shell* :

- déplacez-vous dans votre répertoire personnel,
- créez le répertoire `dubii`,
- déplacez-vous dans ce répertoire.

> **Aide :**:
> > Le caractère `$` au début de chaque ligne est un repère qui représente votre invite de commande. Il ne faut pas entrer ce caractère dans votre ligne de commande.
> > ```bash
> > $ cd ~
> > $ mkdir dubii
> > $ cd dubii
> > ```
{:.answer}

Téléchargez les fichiers des jeux de données du DUBii avec la commande :

```bash
$ git clone https://github.com/DU-Bii/study-cases.git
```

Remarques :

- L'instruction `git` vous sera expliquée un peu plus tard.
- La commande à exécuter est assez longue et complexe. Pour éviter de faire des erreurs et aller plus vite, utilisez le copier/coller. Voici deux méthodes :
    1. Sélectionnez la commande en la surlignant avec le clic gauche de votre souris. Puis dans votre shell, cliquez sur le bouton du milieu de votre souris.
    2. Sélectionnez la commande en la surlignant avec le clic gauche de votre souris. Appuyez ensuite sur les touches `Ctrl` + `C` (c'est-à-dire les touches *Control* et *C* pressées en même temps). Dans votre shell, appuyez sur les touches `Ctrl` + `Maj` + `V` (c'est-à-dire les touches *Control*, *Majuscule* et *V* pressées en même temps).


Patientez quelques instants que les données soient téléchargées.

Déplacez-vous ensuite dans le répertoire `study-cases` nouvellement créé.

> **Aide :**:
> > ```bash
> > $ cd study-cases
> > ```
{:.answer}

Utilisez la commande `tree` pour visualiser l'arborescence qui représente l'organisation des répertoires, sous-répertoires et fichiers.

```bash
$ tree
```

Déplacez-vous maintenant dans le répertoire `Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq`

Astuce : utilisez la touche `Tab` (*Tabulation*) pour compléter les noms des répertoires.

> **Aide :**:
> > ```bash
> > $ cd Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq
> > ```
{:.answer}

Combien de fichiers `.bed` y a t-il dans ce répertoire ?

> **Réponse :**:
> > ```bash
> > $ ls
> > FNR1_vs_input1_cutadapt_bowtie2_homer.bed  FNR_200bp.wig
> > FNR1_vs_input1_cutadapt_bowtie2_macs2.bed  input_200bp.wig
> > ```
> > Il y a deux fichiers `.bed`
{:.answer}


Utilisez la commande `ls` avec les options `l` et `h` pour afficher le contenu du répertoire courant, puis déterminez la taille du fichier `FNR_200bp.wig`.

> **Réponse :**:
> > ```bash
> > $ ls -lh
> > total 264K
> > -rw-r--r-- 1 pierre pierre 8,9K janv. 27 23:25 FNR1_vs_input1_cutadapt_bowtie2_homer.bed
> > -rw-r--r-- 1 pierre pierre  45K janv. 27 23:25 FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
> > -rw-r--r-- 1 pierre pierre  80K janv. 27 23:25 FNR_200bp.wig
> > -rw-r--r-- 1 pierre pierre  90K janv. 27 23:25 input_200bp.wig
> > ```
> > Le fichier `FNR_200bp.wig` a une taille de 80 ko (peut varier légèrement sur votre disque dur).
{:.answer}


En restant dans le même répertoire, déterminez le nombre de fichiers présents dans le répertoire `RNA-seq` qui est au même niveau que le répertoire `ChIP-seq` ?

> **Réponse :**:
> > ```bash
> > $ ls ../RNA-seq
> > cutadapt_bwa_featureCounts_all.tsv
> > ```
> > Il y a un seul fichier.
{:.answer}

---

# Partie 3 : les commandes Linux : aide, répétition, redirection

## Avoir de l'aide sur une commande

Sous Linux toutes les commandes sont documentées de manière standardisée.

Il y a deux moyens d'accèder à l'aide d'une commande :

- via la commande `man <nom_commande>` qui permet d'accéder au manuel
(description complète) de la commande page par page avec les facilités de
recherche d'un éditeur de texte,

- via l'option `<nom_commande> --help`: on affiche un résumé de la
documentation et des options à l'écran.

**Question 8** : Quelle signifie l'option `-N` de la commande less ?

> **Réponse**:
> > ```bash
> > $ man less
> > [...]
> >   -n  -N  ....  --line-numbers  --LINE-NUMBERS
> >                   Don't use line numbers.
> > [...]
> > ```
> L'option `-N` sert à afficher les numéros des lignes à gauche de chaque ligne.
{:.answer}

## Répéter une commande : notion d'historique

Le système d'exploitation Linux garde en mémoire les commandes lancées par un
utilisateur dans un terminal.
La liste des commandes lancées par un utilisateur est accessible via la commande
`history`.
Il est aussi possible de retrouver une commande en utilisant la commande `!`
Par exemple la commande `!?expression?` permet de relancer la dernière commande
utilisée contenant le mot `expression`.
La commande `!grep` permet de relancer la dernière commande utilisée comemnçant par 'grep'

**Question 9** : que fait la commande `!n -3` ?

> **Réponse**:
> > Cette commande permet d'exécuter la 3° dernière commande exécutée.
{:.answer}

On peut également retrouver les commandes déjà exécutées en naviguant dans
l'historique avec les flèches du clavier.


## Sauver le résultat d'une commande Linux dans un fichier : notion de redirection

La possibilité de redirection de l'entrée ou de la sortie standard est une
notion fondamentale du système d'exploitation Linux.

Par défaut tout programme Linux a trois flots de direction :

- une **entrée standard**, appelée `stdin` par défaut associée au **clavier**
- une **sortie standard**, appelée `stdout`, par défaut associée à **l'écran**
- une **erreur standard** appelée `stderr`, par défaut associée à **l'écran**

Une redirection est une modification de l’une de ces associations.
Elle est valable uniquement le temps de la commande sur laquelle elle porte.

Pour modifier l'entrée standard d'une commande en lisant les données d'un
fichier `infile` on utilise `< infile`.

Pour modifier la sortie standard d'une commande et écrire les résultats dans un
fichier `outfile` on utilise `> outfile` ou `>> outfile`

Pour modifier l'erreur standard d'une commande et écrire les messages d'erreurs
dans un fichier `errfile` on utilise : `2> errfile`.

En résumé tout programme Linux peut s'écrire
`$program < infile > outfile 2> errfile`

**Question 10**: rediriger le résultat de la commande `cat` sur le fichier
`ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed` dans le fichier `test.txt`.
Que contient le fichier `test.txt` ?

> **Réponse**
> > ```bash
> > $ cat ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed > test.txt
> > ```
> `cat` affiche le contenu de `ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed`.
> `>` redirige la sortie de la commande vers le fichier `test.txt`.
> Finalement, le fichier `test.txt` contient le contenu du fichier `ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed`.
{:.answer}
