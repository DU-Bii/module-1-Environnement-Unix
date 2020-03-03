# Environnement

## Variables d'environnement

Les variables d'environnement sont un ensemble de variable utilisées
en interne par les différents programmes, ou simplement comme
raccourcis dans le terminal.

### Lister les variables d'environnement

Pour obtenir la liste des variables d'environnement avec les valeurs associées,
on utilise la command `env`.

**Question**: afficher les variables d'environnement sur votre machine

> **Solution**:
> > ```bash
> > $ env
> > LC_ALL=en_US.UTF-8
> > LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
> > SSH_CONNECTION=10.0.2.2 51025 10.0.2.15 22
> > LESSCLOSE=/usr/bin/lesspipe %s %s
> > LANG=en_US.UTF-8
> > XDG_SESSION_ID=11
> > USER=fish
> > PWD=/data
> > HOME=/home/fish
> > LC_CTYPE=UTF-8
> > SSH_CLIENT=10.0.2.2 51025 22
> > SSH_TTY=/dev/pts/0
> > MAIL=/var/mail/fish
> > TERM=xterm-256color
> > SHELL=/bin/bash
> > SHLVL=1
> > LOGNAME=fish
> > XDG_RUNTIME_DIR=/run/user/1000
> > PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
> > LESSOPEN=| /usr/bin/lesspipe %s
> > OLDPWD=/
> > _=/usr/bin/env
> > ```
{:.answer}


### Afficher la valeur d'une variable d'environnement

Pour afficher la valeur d'une variable en particulier, utiliser
`echo`.

Le nom de la variable d'environnement doit être préfixé par le signe `$`.

```bash
$ # Affichage de la variable d'environnement HOME
$ echo ${HOME}
/home/fish

$ # Dans une phrase...
$ echo "This is the value of HOME: ${HOME}"
This is the value of HOME: /home/fish

$ # Une variable d'environnement qui n'existe pas
$ echo "hello: '${SOME_UNDEFINED_ENVIRONMENT_VARIABLE}'"
hello: ''
```


### Définir / supprimer une variable d'environnement

```bash
$ # Définir une variable d'environnement
$ export MY_VARIABLE=12
$ echo ${MY_VARIABLE}
12

$ # Supprimer la variable
$ unset MY_VARIABLE
$ echo ${MY_VARIABLE}

```


### Variables d'environnement importantes

Les variables d'environnement à connaître sont :

- `HOME`, chemin vers le répertoire utilisateur (*home directory*)  
- `PS1`, défini l'aspect du prompt
- `PATH`, liste des répertoires où sont stockés les programmes


## Configuration de l'environnement

### Le bashrc

Le fichier `${HOME}/.bashrc`, est lu par `bash` au démarrage.
Il est souvent utilisé pour définir des variables d'environnement.

### Aliases

Les alias sont des pseudo-commandes que l'on définit et qui servent de raccourcis
pour d'autres commandes.

Pour définir un alias, on utilise la commande `alias`:

```bash
$ # Create an alias for ls -lh
$ alias ll='ls -lh'
$ # Now, typing 'll' as the same effect as 'ls -lh'
$ ll ~/study-cases
total 760K
drwxr-xr-x 4 benoist staff  128 Mar  2 23:49 Arabidopsis_thaliana
drwxr-xr-x 6 benoist staff  192 Mar  2 23:49 Escherichia_coli
drwxr-xr-x 3 benoist staff   96 Mar  2 23:49 Homo_sapiens
drwxr-xr-x 3 benoist staff   96 Mar  2 23:49 img
-rw-r--r-- 1 benoist staff  20K Mar  2 23:49 LICENSE.txt
lrwxr-xr-x 1 benoist staff   14 Mar  2 23:49 README.md -> study-cases.md
-rw-r--r-- 1 benoist staff   50 Mar  2 23:49 _config.yml
-rw-r--r-- 1 benoist staff  228 Mar  2 23:49 study-cases.Rproj
-rw-r--r-- 1 benoist staff 727K Mar  2 23:49 study-cases.html
-rw-r--r-- 1 benoist staff 3.9K Mar  2 23:49 study-cases.md
```
