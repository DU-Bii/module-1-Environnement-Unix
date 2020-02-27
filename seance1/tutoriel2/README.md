# Les bases d'Unix

## Espace disque

### Connaître le taux d'occupation des espaces disques d'un poste de travail

La commande `df` (pour *disk free*) permet de connaître les quantités d'espace occupé et disponible pour tous les disques du système. L'option `-h` permet d'utiliser les multiples "human readable" (ko, Mo, Go, To, ...).

```{bash}
$ df- h
```

### Connaître la quantité d'espace disque occupé par un fichier/dossier.

La commande pour connaître la taille des fichiers présents dans un dossier est `ls -lh`.

<blockquote>
Exemple: Déterminer la quantité d'espace disque occupée par chacun des fichiers présents dans le répertoire `/home/sdv/dubii` et trier les fichiers du plus volumineux au moins volumineux :

```{bash}
$ cd /home/sdv/dubii
$ ls -lh
# Afficher la taille des fichiers du dossier courant
```
</blockquote>

Pour connaître la quantité d'espace disque occupée par un dossier, utiliser la commande `du` (disk usage), encore une fois avec l'option `-h`. On peut affichier la version résumé avec `-s`.

<blockquote>
Exemple: Afficher la taille des sous-dossiers du dossier `/home/sdv/dubii`.

```{bash}
$ du -sh /home/sdv/dubii
```
</blockquote>
