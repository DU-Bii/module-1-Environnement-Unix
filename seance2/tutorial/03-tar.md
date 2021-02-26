# Partie 2.3 : Espace de stockage, compression et archivage des données

Il est de plus en plus facile d'obtenir de plus en plus de données.
Il est important d'être conscient des capacités de stockage de sa machine d'une part,
et du fait qu'un trop grand nombre de fichiers sur une machine peut engendrer
un crash pur et simple du système.

Ainsi, dans ce chapitre nous allons apprendre

- comment savoir si un disque est plein,
- comment connaître la quantité d'espace disque occupé par un fichier/dossier,
- comment trouver les fichiers volumineux sur un disque,
- comment réduire la quantité d'espace disque occupé,
- comment réduire le nombre de fichiers présents sur un disque.


## Connaître la quantité d'espace disque occupée et disponible sur un disque

La commande `df` permet de connaître les quantités d'espace occupé et disponible
pour tous les disques du système.

**Question**: Quelle est la quantité d'espace disque disponible sur votre machine ?

> **Solution**
> > La commande à utiliser est `df -h`, l'option `-h` signifiant "human readable".
> > Autrement dit, cette option donne le résultat en M, G, T et non en B (défaut).
{:.answer}


## Connaître la quantité d'espace disque occupé par un fichier/dossier.

Comme vu précédemment, la commande pour connaître la taille des fichiers présents
dans un dossier est `ls -lh`.

**Question**: Rendez-vous dans le dossier `~/dubii/study-cases/Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016`.
Quelle est la quantité d'espace disque occupée par chacun des fichiers présents
dans ce répertoire ? Trier les fichiers du plus volumineux au moins volumineux.

> **Solution:**
> >```
> >$ cd study-cases/Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016
> >
> >$ # Afficher la taille des fichiers
> >$ ls -lh
> >total 24M
> >-rw-rw-r-- 1 laurent laurent 1.6M Feb  1 10:44 12870_2016_726_MOESM10_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent 1.4M Feb  1 10:44 12870_2016_726_MOESM10_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  37K Feb  1 10:44 12870_2016_726_MOESM12_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  18K Feb  1 10:44 12870_2016_726_MOESM13_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  20K Feb  1 10:44 12870_2016_726_MOESM14_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  17K Feb  1 10:44 12870_2016_726_MOESM15_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  16K Feb  1 10:44 12870_2016_726_MOESM16_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  17K Feb  1 10:44 12870_2016_726_MOESM17_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  30K Feb  1 10:44 12870_2016_726_MOESM18_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  15K Feb  1 10:44 12870_2016_726_MOESM19_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  25K Feb  1 10:44 12870_2016_726_MOESM19_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  13M Feb  1 10:44 12870_2016_726_MOESM1_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent 4.6M Feb  1 10:44 12870_2016_726_MOESM1_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  18K Feb  1 10:44 12870_2016_726_MOESM2_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  34K Feb  1 10:44 12870_2016_726_MOESM2_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent  15K Feb  1 10:44 12870_2016_726_MOESM3_ESM.tsv
> >-rw-rw-r-- 1 laurent laurent  34K Feb  1 10:44 12870_2016_726_MOESM3_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent 1.9M Feb  1 10:44 12870_2016_726_MOESM4_ESM.xlsx
> >-rw-rw-r-- 1 laurent laurent 386K Feb  1 10:44 GSM1388555_WT_0.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent 385K Feb  1 10:44 GSM1388556_WT_1.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent 385K Feb  1 10:44 GSM1388557_WT_8.Gene.rpkm.txt.gz
> >-rw-rw-r-- 1 laurent laurent  729 Feb  1 10:44 README.md
> >```
{:.answer}

Pour connaître la quantité d'espace disque occupée par un dossier, utiliser
la commande `du`, encore une fois avec l'option `-h`.

**Question**: Afficher la taille des sous-dossiers du dossier `~/dubii/study-cases`.
Comment faire pour ne pas tenir compte du dossier `.git` ?

> **Solution**:
> > ```
> > # Taille des sous-dossiers du dossier study-cases
> > $ du -h ~/dubii/study-cases
> > 8.0K    ./img
> > 756K    ./Homo_sapiens/TCGA_study-case
> > 760K    ./Homo_sapiens
> > 236K    ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq
> > 144K    ./Escherichia_coli/bacterial-regulons_myers_2013/data/RNA-seq
> > 384K    ./Escherichia_coli/bacterial-regulons_myers_2013/data
> > 1.1M    ./Escherichia_coli/bacterial-regulons_myers_2013
> > 8.0K    ./Escherichia_coli/genome-sequence_allue-guardia_2019
> > 736K    ./Escherichia_coli/genome-metabolome_fuhrer_2017
> > 1.9M    ./Escherichia_coli
> > 4.0K    ./.git/branches
> > 8.0K    ./.git/logs/refs/remotes/origin
> > 12      ./.git/logs/refs/remotes
> > 8.0K    ./.git/logs/refs/heads
> > 24K     ./.git/logs/refs
> > 32K     ./.git/logs
> > 8.0K    ./.git/info
> > 8.0K    ./.git/refs/remotes/origin
> > 12K     ./.git/refs/remotes
> > 8.0K    ./.git/refs/heads
> > 4.0K    ./.git/refs/tags
> > 28K      ./.git/refs
> > 44K      ./.git/hooks
> > 4.0K     ./.git/objects/info
> > 19M      ./.git/objects/pack
> > 19M      ./.git/objects
> > 20M      ./.git
> > 580K     ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables
> > 2.5M     ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017
> > 24M      ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016
> > 27M      ./Arabidopsis_thaliana
> > 49M
> >
> > # Ne pas tenir compte du dossier .git
> > $ du -h --exclude .git ~/dubii/study-cases
> > 8.0K    ./img
> > 756K    ./Homo_sapiens/TCGA_study-case
> > 760K    ./Homo_sapiens
> > 236K    ./Escherichia_coli/bacterial-regulons_myers_2013/data/ChIP-seq
> > 144K    ./Escherichia_coli/bacterial-regulons_myers_2013/data/RNA-seq
> > 384K    ./Escherichia_coli/bacterial-regulons_myers_2013/data
> > 1.1M    ./Escherichia_coli/bacterial-regulons_myers_2013
> > 8.0K    ./Escherichia_coli/genome-sequence_allue-guardia_2019
> > 736K    ./Escherichia_coli/genome-metabolome_fuhrer_2017
> > 1.9M    ./Escherichia_coli
> > 580K    ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables
> > 2.5M    ./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017
> > 24M     ./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016
> > 27M     ./Arabidopsis_thaliana
> > 30M .
> > ```
{:.answer}



Noter que `find -size` permet de trouver les fichiers en fonction de
leur taille :

```bash
# Trouver les fichiers de plus de 1M
$ find . -size +1M
./.git/objects/pack/pack-ebb930741581bed736361ee821e968dc10c0abef.pack
./Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/data sheet 1.pdf
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.tsv
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.xlsx
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.xlsx
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
./Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM4_ESM.xlsx
```


## Réduire la quantité d'espace disque occupée par un fichier

Il s'agit de compresser un fichier.
Plusieurs outils de compression existent, le plus courant sous unix étant `gzip`
et l'outil de décompression associé `gunzip`.

**Question**: Quelle est la taille du fichier `~/dubii/study-cases/Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv` ?
Le compresser avec `gzip`. Quelle est la taille du fichier compressé ?

> **Solution** :
> > ```
> > $ cd ~/dubii/study-cases/Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/
> > $ # Taille du fichier 12870_2016_726_MOESM1_ESM.tsv
> > $ ls -lh 12870_2016_726_MOESM1_ESM.tsv
> > -rw-rw-r-- 1 laurent laurent 13M Feb  1 10:44 12870_2016_726_MOESM1_ESM.tsv
> > $ # Le fichier fait 13M.
> >
> > $ # Compression du fichier.
> > $ # Attention : par défaut, gzip compresse directement le fichier sans créer de copie
> > $ # On utilise l'option -c pour écrire la sortie sur la sortie standard et > pour rédiriger la sortie standard dans un fichier.
> > $ gzip -c 12870_2016_726_MOESM1_ESM.tsv > 12870_2016_726_MOESM1_ESM.tsv.gz
> >
> > $ # Taille du fichier compressé
> > $ ls -lh 12870_2016_726_MOESM1_ESM.tsv.gz
> > -rw-rw-r-- 1 laurent laurent 2.5M Feb  1 15:44 12870_2016_726_MOESM1_ESM.tsv.gz
> > $ # Le fichier fait 2.5M, soit un taux de compression de 80%.
> > ```
{:.answer}

## Réduire le nombre de fichiers présents sur un disque et compression d'un dossier.

Réduire le nombre de fichiers présents sur un disque consiste à créer une *archive*
d'un dossier.
Cette archive va contenir, en un seul fichier, tous les fichiers présents initialement
dans le dossier.

### Création d'une archive

La commande pour créer une archive est `tar`.

**Syntaxe**: `tar cvf <TARNAME> <SOURCE>`.

`tar` est une commande un peu spéciale puisque certaines options sont accessibles
sans utiliser le caractère `-`.

Voici la signification des options utilisées :

- `c` mode création d'archive
- `f <OUTPUT>` nom du fichier de sortie

Il est également possible d'utiliser l'option `-z` (`tar czf`) pour compresser
l'archive à la volée.

**Exemple**:

```bash
$ # Création d'une archive pour le dossier Arabidopsis_thaliana
$ tar cf Arabidopsis_thaliana.tar Arabidopsis_thaliana

$ # Idem mais en compressant l'archive à la volée.
$ tar czf Arabidopsis_thaliana.tar.gz Arabidopsis_thaliana
```

On peut également utiliser l'option (`-v, --verbose`) pour afficher le nom des
fichiers au fur et à mesure qu'ils sont ajoutés à l'archive) :

```bash
$ # Idem mais en compressant l'archive à la volée.
$ tar cvzf Arabidopsis_thaliana.tar.gz Arabidopsis_thaliana
Arabidopsis_thaliana/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S4 Root exudate proteome.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S4_Root_exudate_proteome.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S2 Root Exudates JL140617.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S3 Analytical Characterization.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S1_Roots.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S3_Analytical_Characterization.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S1 Roots.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S2_Root_Exudates_JL140617.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/README.md
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/data sheet 1.pdf
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM2_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM19_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM14_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/README.md
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM16_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM15_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM17_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM3_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388555_WT_0.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM12_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM13_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM18_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388557_WT_8.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM2_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388556_WT_1.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM4_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM19_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM3_ESM.xlsx
```

Par ailleurs, l'option `--exclude <PATTERN>` permet d'exclude certains fichiers de l'archive.

**Exemple:**

```bash
$ # Création d'une archive du répertoire study-cases en ne tenant pas compte du dossier .git
$ tar cvzf ~/study-cases.tar.gz --exclude ".git" ~/study-cases
```

### Extraction d'une archive

On utilise également l'outil `tar` pour extraire le contenu d'une archive.

**Syntaxe**: `tar xvf <TARNAME> <SOURCE>`.

Ici, on utilise l'option `-x` (*extract*) à la place de l'option `-c` (*create*).
Si l'archive est compressée, on utilise l'option `-z` pour indique au programme
qu'il faudra décompresser l'archive.

**Exemple**:

```bash
# Extraction d'une archive compressée en mode verbeux (verbose)
$ tar xvzf Arabidopsis_thaliana.tar.gz
Arabidopsis_thaliana/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S4 Root exudate proteome.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S4_Root_exudate_proteome.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S2 Root Exudates JL140617.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S3 Analytical Characterization.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S1_Roots.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S3_Analytical_Characterization.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised Suppl Table S1 Roots.xlsx
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/Strehmel revised suppl tables/Revised_Suppl_Table_S2_Root_Exudates_JL140617.tsv
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/README.md
Arabidopsis_thaliana/metabo_proteo_Strehmel_2017/data sheet 1.pdf
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM2_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM19_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM14_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/README.md
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM16_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM15_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM17_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM3_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388555_WT_0.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM12_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM13_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM18_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388557_WT_8.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM10_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM2_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM1_ESM.tsv
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/GSM1388556_WT_1.Gene.rpkm.txt.gz
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM4_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM19_ESM.xlsx
Arabidopsis_thaliana/transcripto_proteo_metabo_Liang_2016/12870_2016_726_MOESM3_ESM.xlsx
```

[Retour au sommaire](index.md)
