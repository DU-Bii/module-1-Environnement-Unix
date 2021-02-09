# Objectifs

- **Répertoires** : Afficher le répertoire courant. Afficher le contenu d'un répertoire. Changer de répertoire. Créer, déplacer et supprimer un répertoire.
- **Aborescence Linux** : Distinguer la notion de chemin absolu et relatif. Utiliser les raccourcis de l'arborescence Linux (`.`, `..`, `~`). Afficher l'arborescence Linux.

## Partie 1 : exploration de fichiers et de répertoires

Sur votre station de travail, ouvrez un *shell*, puis :

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

Remarque :

- La commande à exécuter est assez longue et complexe. Pour éviter de faire des erreurs et aller plus vite, utilisez le copier/coller. Voici deux méthodes :
    1. Sélectionnez la commande en la surlignant avec le clic gauche de votre souris. Puis dans votre shell, cliquez sur le bouton du milieu de votre souris.
    2. Sélectionnez la commande en la surlignant avec le clic gauche de votre souris. Appuyez ensuite sur les touches <kbd>Ctrl</kbd> + <kbd>C</kbd> (c'est-à-dire les touches <kbd>Control</kbd> et <kbd>C</kbd> pressées en même temps). Dans votre shell, appuyez sur les touches <kbd>Ctrl</kbd> + <kbd>Maj</kbd> + <kbd>V</kbd> (c'est-à-dire les touches <kbd>Control</kbd>, <kbd>Majuscule</kbd> et <kbd>V</kbd> pressées en même temps).


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
> > total 240K
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


## Partie 2 : espace disque

### Connaître le taux d'occupation des espaces disques d'un poste de travail

La commande `df` (pour *disk free*) permet de connaître les quantités d'espace occupé et disponible pour tous les disques du système. L'option `-h` permet d'utiliser les multiples "human readable" (ko, Mo, Go, To, ...).

```bash
$ df -h
```

### Connaître la quantité d'espace disque occupé par un fichier/dossier.

La commande pour connaître la taille des fichiers présents dans un dossier est `ls -lh`.
Déplacez-vous maintenant dans le répertoire `Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq`
Astuce : utilisez la touche `Tab` (*Tabulation*) pour compléter les noms des répertoires.

> **Aide :**:
> > ```bash
> > $ cd Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq
> > ```
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

Pour connaître la quantité d'espace disque occupée par un dossier, utiliser la commande `du` (*disk usage*), encore une fois avec l'option `-h`. On peut affichier la version résumé avec `-s`.


Exemple : Déterminer la taille du dossier `study-cases`.

> **Réponse :**:
> > ```bash
> > $ du -sh ./study-cases
 92M	/Users/helenechiapello/Desktop/Hélène/COURS/DUBii/dubii/study-cases
> > ```
> > Le dossier `study-cases` a une taille totale de 92 Mo.
{:.answer}


## Partie 3 : Afficher le contenu d'un fichier

Sous Linux on dispose de plusieurs commandes permettant d'afficher le contenu de fichiers texte de différentes manières.

### cat

Affiche et concatène le contenu du ou des fichiers donnés en arguments
(ou de l'entrée standard) sur la sortie standard.

**Exemple 1**: afficher le contenu du fichier `cutadapt_bwa_featureCounts_all.tsv`
dans le répertoire `RNA-seq`

> **Solution**:
> > ```bash
> > $ cat RNA-seq/cutadapt_bwa_featureCounts_all.tsv
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
et `FNR1_vs_input1_cutadapt_bowtie2_macs2.bed` dans le répertoire `ChIP-seq`.

> **Solution**:
> > ```bash
> > $ cat ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_homer.bed ChIP-seq/FNR1_vs_input1_cutadapt_bowtie2_macs2.bed
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


**Question 1** : quel inconvénient majeur voyez-vous à la commande `cat`?  

> **Réponse**:
> > La commande `cat` affiche la totalité des fichiers ce qui rend la sortie
> > de la commande souvent illisible.
{:.answer}


### less

_less does more or less the same as more, but less does more than more_

La commande `less` permet d'afficher le contenu d'un ou plusieurs fichiers
page par page, ce qui est très utile lorsqu'on manipule des fichiers de taille
importante.

Quelques fonctionnalités utiles :

- `barre d'espace` : faire défiler le contenu page par page  
- `g`: affiche le debut du fichier
- `G`: affiche la fin du fichier
- `/`: recherche les occurences d'un motif
- `n`: passe à l'occurence suivante du motif recherché
- `N`: passe à l'occurence précédente du motif recherché
- `:n` : passe au fichier suivant ('next file', si plusieurs fichiers en arguments)  
- `:p` : passe au fichier précédent ('previous file', si plusieurs fichiers en arguments)
- `q` : quitte less  

**Question 2** : afficher le contenu du fichier
`cutadapt_bwa_featureCounts_all.tsv` avec `less`
> > ```bash
> > less RNA-seq/cutadapt_bwa_featureCounts_all.tsv
> > ```
{:.answer}
### head
La commande `head` permet d'afficher uniquement le début du ou des fichier(s)
passé(s) en argument.
Par défaut, `head` affiche les 10 premières lignes d'un fichier.  
Utiliser l'option `-n <N>` pour afficher les `N` premières lignes d'un fichier.

**Question 3** : afficher les 20 premières lignes du fichier `RNA-seq/cutadapt_bwa_featureCounts_all.tsv`.

> **Réponse**:
> > ```bash
> > $ head -n 20 RNA-seq/cutadapt_bwa_featureCounts_all.tsv
> > Geneid	WT1	WT2	dFNR1	dFNR2
> > b0001	70	98	72	63
> > b0002	23421	33092	32156	20749
> > b0003	7538	10350	9596	6490
> > b0004	8263	11927	11042	7145
> > b0005	121	156	104	62
> > b0006	177	224	287	209
> > b0007	138	116	68	50
> > b0008	2964	3971	4211	2823
> > b0009	213	205	196	128
> > b0010	184	193	130	74
> > b0011	44	13	13	10
> > b0013	18	6	7	3
> > b0014	10758	14747	15432	10243
> > b0015	1343	1667	1549	1045
> > b0016	261	326	252	141
> > b4412	0	0	0	0
> > b0018	7	0	2	1
> > b4413	1	0	1	1
> > b0019	714	944	1093	704
> > ```
{:.answer}

### tail

La commande `tail` permet d'afficher uniquement la fin du ou des fichier(s)
passé(s) en argument.
Par défaut `tail` affiche les 10 dernières lignes d'un fichier.
Utiliser l'option `-n N` pour afficher les `N` dernières lignes d'un fichier.

**Question 4** : afficher les 20 dernières lignes du fichier `RNA-seq/cutadapt_bwa_featureCounts_all.tsv`.

> **Réponse**:
> > ```bash
> > $ tail -n 20 RNA-seq/cutadapt_bwa_featureCounts_all.tsv
> > b4384	846	1241	1173	751
> > b4385	205	224	145	84
> > b4386	243	233	192	106
> > b4387	164	197	142	98
> > b4388	409	489	404	264
> > b4389	712	785	615	350
> > b4390	421	535	471	316
> > b4391	2341	2740	2888	1913
> > b4392	538	601	717	464
> > b4393	203	258	202	137
> > b4394	256	292	243	167
> > b4395	404	591	422	309
> > b4396	903	1161	1055	709
> > b4397	235	280	242	143
> > b4398	210	251	178	122
> > b4399	166	115	122	101
> > b4400	82	42	37	35
> > b4401	3349	4692	2619	1609
> > b4402	201	318	224	128
> > b4403	82	116	87	68
> >
> >
{:.answer}


## Partie 4 : L'éditeur de texte nano

Il existe beaucoup d'éditeurs de fichiers textes sour Linux.

Parmi les plus connus on trouve : `vi`, `emacs` et `nano`.  
___Nano___ est l'éditeur le plus simple à utiliser.

**Question 5** : qu'est-ce qu'un un éditeur de texte ? Quelle différence avec un traitement de texte ?

> **Réponse**
> > éditeur = programme permettant de modifier des fichiers texte sans mise en forme
> > traitement de texte = logiciel le plus souvent avec une interface graphique pour mettre en forme des documents
{:.answer}

Pour lancer l'éditeur de texte nano : il vous suffit de taper `nano`
éventuellement suivi d'un nom de fichier à éditer.

Toutes les commandes sont résumées dans le bandeau en bas de l'écran
Le symbole `^` signifie <kbd>CTRL</kbd> (la touche Contrôle de votre clavier).

Voici les raccourcis les plus importants :
- `Ctrl-G` : afficher l'aide
- `Ctrl-K` : couper la ligne de texte (et la mettre dans le presse-papier)
- `Ctrl-U` : coller la ligne de texte que vous venez de couper
- `Ctrl-C` : afficher à quel endroit du fichier votre curseur est positionné (numéro de ligne)
- `Ctrl-W` : rechercher une chaine de caractères dans le fichier
- `Ctrl-O` : enregistrer le fichier (écrire)
- `Ctrl-X` : quitter Nano.

Vous pouvez vous déplacer dans le fichier avec les flèches du clavier ainsi
qu'avec les touches <kbd>PageUp</kbd> et <kbd>PageDown</kbd> pour avancer
de page en page (les raccourcis <kbd>CTRL-Y</kbd> et <kbd>CTRL-V</kbd> fonctionnent aussi).

**Question 6** : ouvrir avec l'éditeur `nano` le fichier `Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`  

**Recommandations :**  
- Créer un répertoire `~/dubii/study-cases/Escherichia_coli/bacterial-regulons_myers_2013/data/Annotations`  
- Dans un navigateur internet, ouvrir la page <https://du-bii.github.io/study-cases/Escherichia_coli/bacterial-regulons_myers_2013/>
- Cliquer sur *Genome annotations (GFF3 format)* pour télécharger le fichier `Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`
- Le déplacer dans le répertoire précédemment créé (`~/dubii/study-cases/Escherichia_coli/bacterial-regulons_myers_2013/data/Annotations`)
- Décompresser ce fichier avec la commande `gunzip Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3.gz`
- vérifier que le fichier `Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3` existe.
- Rechercher les lignes contenant le nom de gène `oriC` et afficher le numéro de ces lignes
- Supprimer ces lignes
- Enregistrer le fichier sous le nom `Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome_wo_oriC.gff`

Remarques :

- pour rechercher un mot plusieurs fois sans le réécrire, tapez juste `Ctrl-W ENTER`
- si vous voulez sortir du mode recherche, tapez `CTRL-C`

> **Réponse**  
> > Utiliser successivement les commandes :  
> > - `Ctrl-W` pour rechercher `oriC`
> > - `Ctrl-C` pour connaitre le numéro de ligne courante  
> > - `Ctrl-K` pour supprimer la ligne courante  
> > Au moment de sauvergarder le fichier avec la commande `Ctrl-O` penser à modifier le nom du fichier  
> > Les 4 occurences de `oriC` sont aux lignes 4859, 8256, 18950 et 22228 dans le fichier original (4859, 8255, 18948 et 22225 si vous supprimez les lignes au fur et à mesure)
> >
> >
{:.answer}


## Partie 5 : Avoir de l'aide sur une commande

Sous Linux toutes les commandes sont documentées de manière standardisée.

Il y a deux moyens d'accèder à l'aide d'une commande :

- via la commande `man <nom_commande>` qui permet d'accéder au manuel
(description complète) de la commande page par page avec les facilités de
recherche d'un éditeur de texte,

- via l'option `<nom_commande> --help`: on affiche un résumé de la
documentation et des options à l'écran.

**Question 7** : Quelle signifie l'option `-N` de la commande less ?

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


## Partie 6 : Répéter une commande, notion d'historique

Le système d'exploitation Linux garde en mémoire les commandes lancées par un
utilisateur dans un terminal.
La liste des commandes lancées par un utilisateur est accessible via la commande
`history`.
Il est aussi possible de retrouver une commande en utilisant la commande `!`
Par exemple la commande `!?expression?` permet de relancer la dernière commande
utilisée contenant le mot `expression`.
La commande `!grep` permet de relancer la dernière commande utilisée comemnçant par 'grep'

**Question 9** : que fait la commande `!-3` ?

> **Réponse**:
> > Cette commande permet d'exécuter la 3° dernière commande exécutée.
{:.answer}

On peut également retrouver les commandes déjà exécutées en naviguant dans
l'historique avec les flèches du clavier.


## Partie 7 : Sauver le résultat d'une commande Linux dans un fichier

La possibilité de redirection de l'entrée ou de la sortie standard est une
notion fondamentale du système d'exploitation Linux.

Par défaut tout programme Linux a trois flux de données :

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
