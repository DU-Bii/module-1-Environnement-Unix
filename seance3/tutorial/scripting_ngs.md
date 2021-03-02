# Exploration de données COVID-19 avec bash
T. Denecker et H. Chiapello

## Informations générales

### Objectif

L'objectif de ce TP est de télécharger et vérifier quelques fichiers de séquences de la COVID-19 à l'aide de scripts bash. Les fichiers proviennent de l'European National Archive (ENA) qui est la plateforme européenne chargée de la gestion, du partage, de l’intégration, de l’archivage et de la diffusion des données de séquences [Pour en savoir plus](https://www.ebi.ac.uk/ena/browser/about).

Une page de documention est proposée par l'ENA pour télécharger les séquences qui y sont hébergées : [ici](https://ena-docs.readthedocs.io/en/latest/retrieval/file-download.html).

### Étapes

Plusieurs étapes seront réalisées lors de ce TP :

1) Créer un dossier pour organiser les fichiers télécharges
2) Téléchargement des fichiers avec la commande `wget`
3) Exploration des fichiers :
    - pour chaque fichier fastq, nous allons compter le nombre de séquences. Si le nombre de séquences est en dessous d’une certaine valeur, nous allons afficher un message (dans le cas par exemple où on voudrait un nombre minimal de reads par fichiers).

Pour compter le nombre de reads, il y aura 2 stratégies :

- Soit compter le nombre de lignes et diviser cette valeur par 4 (sachant qu’un reads c’est 4 lignes);
- Soit compter le nombre de lignes qui ne contiennent que + (la 3e ligne pour des reads récents séquencés par illumina).

### La commande `wget`

> Wget est un programme en ligne de commande non interactif de téléchargement de fichiers depuis le Web. Il supporte les protocoles HTTP, HTTPS et FTP ainsi que le téléchargement au travers des proxies HTTP. Il est disponible sur presque tous les environnements Unix.

Pour en savoir plus : [ici](https://doc.ubuntu-fr.org/wget)


### Les données

Les données utilisées ont été sélectionnées sur le site [COVID-19 Data Portal](https://www.covid19dataportal.org/sequences?db=embl-covid19).

Nous pouvons y télécharger le fichier de métadonnées suivant :

``` bash
"accession id"	"accession id"	"description"	"country"	"region"
"SRX5082690"	""	"Illumina MiSeq paired end sequencing; OC43 PR2 amplicon sequencing"	"France"	"Lille"
"SRX5082692"	""	"Illumina MiSeq paired end sequencing; OC43 MDS15 amplicon sequencing"	"France"	"Lille"
"SRX5082694"	""	"Illumina MiSeq paired end sequencing; OC43 MDS4 amplicon sequencing"	"France"	"Lille"
```

## Mise en pratique

### Script 1 - Téléchargement des données

#### Création d'un dossier de téléchagement

Création d'un dossier à l'aide de la commande `mkdir` ([documentation](http://manpages.ubuntu.com/manpages/bionic/fr/man1/mkdir.1.html))

``` bash
mkdir COVID19_FASTQ
```

#### Téléchargement des fichiers à l'aide de la commande `wget`

Un paramètre intéressant de la commande wget est la possibilité de rediriger le fichier téléchargé dans un dossier spécifié : `-P DOSSIER/DESTINATION`

``` bash
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR826/006/SRR8265756/SRR8265756_1.fastq.gz -P FASTQ
```

Cette commande doit être dupliquée pour chaque fichier que vous souhaitez télécharger.


#### Script final

Note : N'oublier pas de faire un `chmod +x NOM_SCRIPT` pour rendre votre script executable.

> **Solution :**:
> > ``` bash
> > #!/bin/bash
> > 
> > ##------------------------------------------------------------------------------
> > ## Objectifs du script :  
> > ##     - Télécharger un ensemble de 5-6 fichier de reads de l’ENA 
> > ##     - Les stocker dans un répertoire dédié.
> > ## Auteurs: Hélène Chiapello & Thomas Denecker
> > ## Affiliation: IFB
> > ## Organisme : SARS-CoV-2
> > ## Date: Mars 2021
> > ## Étapes :
> > ## 1- Creation des dossiers de reception
> > ## 2- Téléchagement des fichiers
> > ##------------------------------------------------------------------------------
> > 
> > echo "=============================================================="
> > echo "Creation des dossiers"
> > echo "=============================================================="
> > 
> > mkdir COVID_META 
> > mkdir COVID_FASTQ
> > 
> > echo "--------------------------------------------------------------"
> > echo "Experiment: SRX5082690"
> > echo "Illumina MiSeq paired end sequencing;"
> > echo "OC43 PR2 amplicon sequencing"
> > echo "--------------------------------------------------------------"
> > 
> > for j in $(tail -n +1 sra-experiment-covid19-idlist.txt)
> > do
> >     id=$( echo "$j" |cut -f1 )
> >     echo "--------------------------------------------------------------"
> >     echo ${id}
> >     echo "--------------------------------------------------------------"
> >     wget "https://www.ebi.ac.uk/ena/portal/api/filereport?accession=${id}&result=read_run&fields=study_accession,sample_accession,experiment_accession,run_accession,tax_id,scientific_name,fastq_ftp,submitted_ftp,sra_ftp&format=tsv&download=true" -O COVID_META/"${id}".tsv
> >    adress=$(head -n 2 COVID_META/${id}.tsv |cut -f7)
> >     arrIN=(${adress//;/ })
> >     wget ${arrIN[1]} -P COVID_FASTQ
> >     wget ${arrIN[2]} -P COVID_FASTQ
> > done

> > ```
{:.answer}

#### Architecture du projet

``` bash
$ tree 
.
├── FASTQ
│   ├── SRR8265752_1.fastq.gz
│   ├── SRR8265752_2.fastq.gz
│   ├── SRR8265754_1.fastq.gz
│   ├── SRR8265754_2.fastq.gz
│   ├── SRR8265756_1.fastq.gz
│   └── SRR8265756_2.fastq.gz
└── script1.sh
```

**Pour aller plus loin :**

- Donner le fichier contenant les données à télécharger en argument de la ligne de commande du script
- Vérifier l'intégrité des fichiers téléchargés avec par exemple la commande `md5sum`.


### Script 2 - Exploration

Nous souhaitons à présent explorer ces fichiers. Pour réaliser cette exploration, nous allons utiliser une boucle `for` qui va itérer sur tous les fichiers présents dans le dossier `COVID_FASTQ` et qui termine par `.fastq.gz`.

#### Stratégie 1

Nous allons compter le nombre de lignes et diviser cette valeur par 4 (sachant qu’un reads c’est 4 lignes). Pour le vérifier, nous avons par exemple la page [wikipedia](https://fr.wikipedia.org/wiki/FASTQ) ou encore une documentation proposée par [Illumina](https://emea.support.illumina.com/bulletins/2016/04/fastq-files-explained.html)

> ** Solution :**
> > ``` bash
> > #!/bin/bash
> > 
> > ##------------------------------------------------------------------------------
> > ## Objectifs du script :  
> > ##     - Explorer les fichiers fastq.gz d'intérêt
> > ## Auteurs: Hélène Chiapello & Thomas Denecker
> > ## Affiliation: IFB
> > ## Organisme : SARS-CoV-2
> > ## Date: Mars 2021
> > ## Étapes :
> > ## 1- Compter le nombre de reads et alerter si le nombre est trop faible
> > ##------------------------------------------------------------------------------
> > 
> > limit=2000000
> > 
> > for i in COVID_FASTQ/*.fastq.gz
> > do
> >    count=$(gunzip -c $i | echo $((`wc -l`/4)))
> > 
> >     echo "============================================================="
> >     echo "$i"
> >     echo "============================================================="
> >     
> >     echo "Nombre de reads du fichier :" "$count"
> > 
> >     if [ "$count" -lt "$limit" ]
> >     then
> >         echo "/!\\ Il y a moins de 2000000 de reads dans le fichier"
> >     fi
> > 
> > done
> > ```
{:.answer}

#### Stratégie 2

Nous allons compter cette fois le nombre de lignes qui ne contiennent que + . D'apèrs la documentation, la 3e ligne pour des reads récents séquencés par illumina ne contient que le signe `+`.

Nous allons donc utiser grep pour rechercher toutes les lignes commençant (`^`) par la signe `\+` (le \ permet d'échapper le signe + qui est un caractère spécial) et qui termine par un plus `$`. 

> ** Solution**
> > ``` bash
> > #!/bin/bash
> > 
> > ##------------------------------------------------------------------------------
> > ## Objectifs du script :  
> > ##     - Explorer les fichiers fastq.gz d'intérêt
> > ## Auteurs: Hélène Chiapello & Thomas Denecker
> > ## Affiliation: IFB
> > ## Organisme : SARS-CoV-2
> > ## Date: Mars 2021
> > ## Étapes :
> > ## 1- Compter le nombre de reads et alerter si le nombre est trop faible
> > ##------------------------------------------------------------------------------
> > 
> > limit=2000000
> > 
> > for i in COVID_FASTQ/*.fastq.gz
> > do
> >     count=$(gunzip -c $i | echo $((`grep -i "^\+$" | wc -l` )))
> > 
> >     echo "============================================================="
> >     echo "$i"
> >     echo "============================================================="
> >     
> >     echo "Nombre de reads du fichier :" "$count"
> > 
> >     if [ "$count" -lt "$limit" ]
> >     then
> >         echo "/!\\ Il y a moins de 2000000 de reads dans le fichier"
> >     fi
> > 
> > done
> > ```
{:.answer}

**Pour aller plus loin**

Nous vous proposons 
- de mettre en paramètre du script sur la ligne de commande le seuil (nombre de reads minimal) à obtenir par fichier
- d'écrire les résultats de cette analyse (seuil utilisé, puis avec 1 ligne par fichier : le nom du fichier fastq, nombre de lectures totales dans le fichier et warning si le seuil minimum n'est pas atteind dans ce fichier de sortie)

**Note : Pour les utilisateurs de Mac qui ne disposent pas de wget**

La commande n'est plus installée par défaut dans le terminal mac. Nous vous conseillons de l'installer à l'aide de [Homebrew](https://brew.sh/index_fr) :

``` bash
# Installation de Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installation de wget 
brew install wget
```

