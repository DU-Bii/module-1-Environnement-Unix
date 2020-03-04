## Synopsis

L'objectif de ce module est de vous familiariser avec l'environnement Unix et ses principales commandes.

Lien court vers cette page : <https://huit.re/dubii-m1>

Rappel des prérequis : <https://du-bii.github.io/accueil/activites_preparatoires/>


## Intervenants

- Hélène Chiapello, INRAE, `helene.chiapello@inrae.fr`, [@HeleneChiapello](https://twitter.com/HeleneChiapello)
- Pierre Poulain, Université de Paris, `pierre.poulain@univ-paris-diderot.fr`, [@pierrepo](https://twitter.com/pierrepo)
- Benoist Laurent, CNRS, `benoist.laurent@ibpc.fr`
- Julien Seiler, IGBMC, `seilerj@igbmc.fr`
- Jacques van Helden, Institut Français de Bioinformatique et Univ. Aix-Marseille, `Jacques.van-Helden@univ-amu.fr`
- Sandra Dérozier, INRAE, `sandra.derozier@inrae.fr`
- Hubert Santuz, CNRS, `hubert.santuz@ibpc.fr`


## Séance 1 - Premiers pas

- Lundi 02/03/2020 14:30 - 17:30
- Instructeurs : Hélène Chiapello & Pierre Poulain
- helpers : Benoist Laurent & Hubert Santuz

[Introduction](seance1/slides_intro/Unix_seance1_introduction_methodes.pdf) - [Tutoriel 1](seance1/tutorial1/README.md) - [Tutoriel 2](seance1/tutoriel2/README.md) - [Bonnes pratiques](seance1/slides_good_practices/Unix_seance1_bonnes_pratiques_bioinfo.pdf)

Bibliographie / webographie

- Livre : [Bioinformatics Data Skills](http://shop.oreilly.com/product/0636920030157.do), Vince Buffalo, O'Reilly Media, 2015.
- Article : [A Quick Guide to Organizing Computational Biology Projects](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424), Noble, PLOS Comput Biol, 2009.
- Article : [Good enough practices in scientific computing](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510), Wilson et al., PLOS Comput Biol, 2017.
- Mémo : [A Critical Guide to Unix](https://f1000research.com/documents/7-1436), Attwood, F1000 Research, 2018.
- Site internet : [The UNIX Shell](http://swcarpentry.github.io/shell-novice/), cours en ligne de *Software Carpentry*.
- Site intenet : [Unix Fondamentals](https://edu.sib.swiss/pluginfile.php/2878/mod_resource/content/4/couselab-html/content.html), du *Swiss Institute of Bioinformatics*.

## Séance 2 - Gestion de flux et extraction de données

- Mardi 03/03/2020 14:30 - 17:30
- Instructeurs : Hélène Chiapello & Benoist Laurent
- Helpers : Sandra Derozier & Pierre Poulain


- [Présentation](seance2/slides/index.html) <br />
- [Support](seance2/tutorial/index.md)
    - [Extraction et flux de données](seance2/tutorial/01-flux.md)
    - [Expressions régulières](seance2/tutorial/02-regex.md)
    - [Compression et archivage](seance2/tutorial/03-tar.md)
    - [Travail à distance (ssh & scp)](seance2/tutorial/04-ssh_scp.md)


## Séance 3 - Gestion et utilisation des ressources IFB

- Jeudi 05/03/2020 9:00 - 12:00
- Instructeurs : Julein Seiler & Pierre Poulain
- Helpers : Hélène Chiapello, Benoist Laurent & Jacques van Helden

<!--
[Tutoriel](seance3/tutorial/README.md)

[Changer son prompt](seance3/slides/index.html)

Bibliographie / webographie

- Site internet : [IFB SLURM cluster user guide](http://taskforce-nncr.gitlab.cluster.france-bioinformatique.fr/doc/slurm_user_guide/), guide d'utilisation du *cluster SLURM de l'Institut Français de Bioinformatique*.
-->

## Séance 4 - Automatisation

- Mardi 10/03/2020 9:30 - 12:30
- Instructeurs : Benoist Laurent & Hélène Chiapello
- Helper : Pierre Poulain

<!--
[Tutoriel](seance4/tutorial/README.md)

[Présentation](seance4/slides/index.html)
-->


## Installer un *shell* Linux sur sa machine

### Linux et Mac OS X

Si vous travaillez avec les systèmes d'exploitations Linux (Ubuntu, Mint, Debian...) ou Mac OS X, vous avez déjà un *shell* installé sur votre machine.

### Windows

Si vous travaillez avec Windows :

- Pour Windows 7. Nous vous conseillons d'installer [Git pour Windows](https://git-for-windows.github.io/) qui en plus du gestionnaire de versions git installera un *shell* Linux.
- Pour Windows 10. Vous pouvez installer très rapidement un *shell* Linux. Voici quelques liens pour y arriver :
    + [Installer le shell Bash Linux sous Windows 10 avec WSL](https://www.youtube.com/watch?v=CyG16N3GJWo), 2020.
    + [How to install Windows Subsystem for Linux (WSL) on Windows 10](How to install Windows Subsystem for Linux (WSL) on Windows 10), 2019.
    + [Everything You Can Do With Windows 10’s New Bash Shell](https://www.howtogeek.com/265900/everything-you-can-do-with-windows-10s-new-bash-shell/), 2018.

    Depuis un *shell* Linux, votre répertoire utilisateur de Windows est accessible via le chemin `/mnt/c/Users/<login-windows>` ou `<login-windows>` est votre *login* sous Windows. Nous vous conseillons de travailler depuis ce répertoire afin que vos fichiers puissent également être visibles depuis Windows.

Si vous souhaitez simplement un logiciel sous Windows pour vous connecter au cluster du NNCR en SSH. Nous vous conseillons [MobaXterm](https://mobaxterm.mobatek.net/). La version [*Free*](https://mobaxterm.mobatek.net/download.html) est suffisante. Vous trouverez quelques vidéos de démo [ici](https://mobaxterm.mobatek.net/demo.html).

Pour copier / coller entre Windows et le *shell* Linux :

- Pour copier depuis Windows (<kbd>Ctrl</kbd>+<kbd>C</kbd>) puis coller dans le *shell* : clic droit de la souris.
- Pour copier depuis le *shell* (<kbd>Ctrl</kbd>+<kbd>Maj</kbd>+<kbd>C</kbd>) puis coller dans Windows (<kbd>Ctrl</kbd>+<kbd>V</kbd>)


## Licence

![](img/CC-BY-SA.png)

Ce contenu est mis à disposition selon les termes de la licence [Creative Commons Attribution - Partage dans les Mêmes Conditions 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/deed.fr) (CC BY-SA 4.0). Consultez le fichier [LICENSE](LICENSE) pour plus de détails.
