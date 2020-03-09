
# Partie 2.5: rsync

**Syntax**: `rsync [options] <SOURCE> <DESTINATION>`

`rsync` est un outil très puissant servant à faire notamment de la copie et 
du transfert de fichier.
Sa particularité est qu'il est capable de détecter des fichiers ou dossier
ajoutés/supprimés/modifiés dans la `SOURCE` et de ne copy que ceux-ci dans
le répertoire de `DESTINATION`.

Cette une différence majeure avec `cp` qui lui copie `SOURCE` vers `DESTINATION`
de manière brutale.

Cette capacité à ne transférer que la partie "utile" de la `SOURCE` permet
d'économiser un temps précieux lors de la copie de fichiers volumineux.

`rsync` a de nombreuses options, les plus utilisées étant :

- `-a, --archive` mode archive (typiquement ce qu'on veut 95% du temps)
- `-v, --verbose` mode verbeux  (afficher les éléments au fur et à mesure qu'il sont copiés)
- `-P, --progress` montre l'avancement, fichier par fichier
- `-h, --human-readable` montre les tailles au format humain (à utiliser avec `-P`)
- `-x, --exclude <MOTIF>` exclut des éléments de la copie.


- [Copie simple](#copie-simple)
- [Copie depuis/vers une machine distance](#copie-depuis-vers-une-machine-distante)
- [Copie de fichiers volumineux](#copie-de-fichiers-volumineux)

## Copie simple

```bash
$ rsync -av study-cases /data/
building file list ... done
study-cases/
study-cases/.gitignore
study-cases/LICENSE.txt
study-cases/README.md -> study-cases.md
study-cases/_config.yml
study-cases/study-cases.Rproj
study-cases/study-cases.html
study-cases/study-cases.md
study-cases/.git/
study-cases/.git/HEAD
study-cases/.git/config
[...]
```

Si seulement un fichier est modifié et qu'on relance la copie, seulement ledit
fichier est copié :

```bash
$ # Modifying README.md
$ echo "modifying README" >> study-cases/study-cases.md
$ # Making the copy again
$ rsync -av study-cases /data/
sending incremental file list
study-cases/study-cases.md

sent 8,153 bytes  received 67 bytes  16,440.00 bytes/sec
total size is 50,480,444  speedup is 6,141.17
```


## Copie depuis/vers une machine distance]

`rsync` peut être utilisé comme alternative (plus efficace) à `scp`.


**Copie depuis une machine distante**:

```bash
rsync -a login@server.domain:study-cases .
```

**Copie vers une machine distante**:

```bash
rsync -a study-cases login@server.domain:
```


## Copie de fichiers volumineux

Lorsqu'on copie des fichiers volumineux, il peut être intéressant d'utiliser
les options `-Ph` pour voir l'avancement du processus :

```bash
$ rsync -aPh my-big-file.tar.gz login@server.domain:
building file list ...
1 file to consider
my-big-file.tar.gz
     301.75M  22%   71.97MB/s    0:00:14
```








