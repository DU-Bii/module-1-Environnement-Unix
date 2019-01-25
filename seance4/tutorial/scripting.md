
# Automatisation: script writing

## Writing a script

Writing a proper script is an essential part of doing analyses on a computer.
Not only it is a way of automatizing a process, it is also the good way of
keeping track of the process itself.
A script allows 

- to reproduce a process
- to check a process has no bug
- to easily update a process with new steps
- to store a command output in a variable, preventing the creation of temporary files

This is as critical as writing a laboratory handbook.


### Getting the command history

A way of writing a script is to first type the commands in your shell to
make sure they work, second to access the command history, and finally to
copy/paste commands in a text file.

The history of commands can be accessed simply using the keyboard arrows:
up and down arrows allow to go backwards and forwards in history.

Alternatively, the `history` command provides the last typed commands.
`history` actually provides a huge number of commands so it may be better to
use it in combination with `tail` to only get the last commands used:

```bash
$ history | tail -n 3
  120  wc -l molecules/p*.pdb
  121  wc -l creatures/* | tail -1
  122  history |tail -n 3
```


### Defining variables

Variables are defined in a script in the same fashion as in the terminal:

```bash
# Define a variable named "VAR" with value 42
VAR=42

# Print the variable value
echo $VAR
```

The output of a command can be stored in a variable for later use.
It is then necessary to put the command between ` characters.

```bash
# Store file names into a variable
FILENAMES=`ls -1 molecules`

# Display the file names
echo "the filenames:"
echo "$FILENAMES"
```


### Writing our first script: a file's first line

Let's say we want to write a script that displays the first line of a file
with the file's name next to it.

Let's create `first_line.bash` with a text editor and write those lines:

```bash
FILE=molecules/cubane.pdb
HEAD=`head -1 $FILE`
echo "$FILE: $HEAD"
```


### Executing a script

To execute the script we just wrote, we can execute it or "invoke" it in a terminal
simply by typing `bash first_line.bash`:

```bash
$ bash first_line.bash
molecules/cubane.pdb: COMPND      CUBANE
```

Alternatively, we can add the sheband (`#!/bin/bash`) at the beginning of the
file and make the script executable with `chmod +x <script>` and the execute it:

```bash
$ # Add the shebang to the script: we use sed in interactive insertion mode
$ # We could as well use a classic text editor.
$ sed '1 i\#!/bin/bash' first_line.bash
$ chmod +x first_line.bash
$ ./first_line.bash
molecules/cubane.pdb: COMPND      CUBANE
```

### Passing arguments to a script

In the script we wrote, the input file is defined by the variable `FILE`.
It has the value `molecules/cubane.pdb`, meaning that if we want to run the
script on another file, we have to modify the script.

So it may be conveniant to have a script that takes the input file name as an
argument.

Inside a script, the variables named by numbers represent the command-line
arguments (e.g. `$1` is the first argument, `$10` the tenth argument, etc).

`$#` contains the number of arguments passed to the script.

**Question**: adapt the script so that it takes the input file name from
the command-line.

> **Solution**:
> > ```bash
> > FILE=$1
> > HEAD=`head -1 $FILE`
> > echo "$FILE: $HEAD"
> > ```
{:.answer}


### Repeating a series of commands for each of multiple files

Now if we want our script to work on several input files, we have to repeat
the same instructions **for each** file.

The important word here is *for each*, highlighting the concept of loop.

So, assuming that several input files were provided from the command-line, our
script becomes:

```bash
# Store file names into a variable: $* represents all command-line arguments.
FILENAMES=$*

for FILE in $FILENAMES
do
    HEAD=`head -1 $FILE`
    echo "$FILE: $HEAD"    
done
```


### Checking everything is going well: tests

An test block starts with the keyword `if` and ends with `fi`
(which is `if` reversed).
In between, it is possible do add as many `else` and `elif` (the contraction
of `else if`) as necessary:

```bash
# The -gt operator stands for "greater than"
if [ $# -gt 1 ]; then
    echo "There are more than 1 command-line arguments ($# to be precise)"
# The -eq operator checks for equality
elif [ $# -eq 1 ]; then
    echo "There is 1 command-line argument"
else
    echo "There are no command-line argument"
fi
```

**Question**: adapt `first_line.bash` so that it runs as well
whether a single or multiple files are passed to the command-line.
The script will display an error message if no input file is provided.

> **Solution**:
> > ```bash
> > # The -ge operator stands for "greater or equal"
> > if [ $# -ge 1 ]; then
> >     FILENAMES=$*    
> >     for FILE in $FILENAMES
> >     do
> >         HEAD=`head -1 $FILE`
> >         echo "$FILE: $HEAD"    
> >     done
> > else
> >     echo "ERROR: no file provided from command-line"
> > fi
> > ```
{:.answer}