# Environment

## Environment variables

Environment variables are a set of variables which can be used internaly
in some programs, or just as shortcuts in the terminal.

### Listing environment variables

To get the list of all environment variables with their values, type `env`.

**Question**: display the list of environment variables

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


### Displaying a variable's value

To display a single variable's value, use `echo`, which basically prints
a message.
So `echo coucou` will simply print "coucou", while `echo $HOME` prints
the value of the `HOME` variable (`$HOME` refers to the value for the 
`HOME` variable):

```bash
$ echo $HOME
/home/fish

$ echo "This is the value of HOME: $HOME"
This is the value of HOME: /home/fish
```

Importantly, trying to use a environment variable that hasn't been defined
is equivalent to using a variable set to empty string:

```bash
$ echo "hello: '$SOME_UNDEFINED_ENVIRONMENT_VARIABLE'"
hello: ''
```


### Setting/unsetting a variable value

To set an envionement varible:

```bash
$ export MY_VARIABLE=12
$ # Check the result
$ echo $MY_VARIABLE
12
```

To unset this environment variable, use the command `unset`:

```bash
$ export FOO="I am Groot"
$ echo "FOO is: '$FOO'"
FOO is: 'I am Groot'
$ unset FOO
$ echo "FOO is: '$FOO'"
FOO is: ''
```


### Important environment variables

The most important environment variable would be

- `HOME`, path to your home directory which is the place were numerous hidden files are stored
- `PS1`, defines the look of your command-line prompt
- `PATH`, stores the list of directories where executables are to be found.


## Configuring the environment

### The `$HOME/.bashrc` file

A file is often used to configure the environment.
This file, `$HOME/.bashrc`, is read by `bash`, the terminal interpreter upon
start.

### Aliases

Aliases are pseudo-commands you defined as shortcuts for other commands.
As an example, you'll probably want to list a directory's content and getting
file sizes quite often.
We saw in chapter [Manipulating files and directories](./manipulating_files_and_directories#knowing-files-size) 
that the command for that is `ls -lh`.
A way to get faster at typing this command is by creating an *alias*, i.e. a
shorter pseudo-command that will do the same thing.

The command to create an alias is...`alias`:

```bash
$ # Create an alias for ls -lh
$ alias ll='ls -lh'
$ # Now, typing 'll' as the same effect as 'ls -lh'
```


### Setting global environment varialbles

To set an environment variable value on a global level, the command to use
is `export`.

For example, a current practice is to store some executables in your home
directory, more precisely in `$HOME/.local/bin`.
To append this directory to the list of directories where executable should
be looked for, type: `export PATH=$HOME/.local/bin:$PATH`
