
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
var=42

# Print the variable value
echo ${var}
```

The output of a command can be stored in a variable for later use.
It is then necessary to put the command between ` characters.

```bash
# Store file names into a variable
filenames=$(ls -1 molecules)

# Display the file names
echo "the filenames:"
echo "${filenames}"
```


### Writing our first script: a file's first line

Let's say we want to write a script that displays the first line of a file
with the file's name next to it.

Let's create `first_line.bash` with a text editor and write those lines:

```bash
fname=molecules/cubane.pdb
thehead=$(head -1 $FILE)
echo "${fname}: ${thehead}"
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
> > fname=$1
> > thehead=$(head -1 $FILE)
> > echo "${fname}: ${thehead}"
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
filenames=$*

for fname in ${filenames}
do
    thehead=$(head -1 ${fname})
    echo "${fname}: ${thehead}"    
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
> >     filenames=$*    
> >     for fname in ${filenames}
> >     do
> >         thehead=$(head -1 ${fname})
> >         echo "${fname}: ${thehead}"    
> >     done
> > else
> >     echo "ERROR: no file provided from command-line"
> > fi
> > ```
{:.answer}


## Do reinvent the wheel

Everybody has been told numerous times that he shouldn't reinvent the wheel.
**This statement is true: do not reinvent the wheel.**

However, this is what could happen when you decide not to reinvent the wheel
and use a pipeline made of existing tools to complete a analysis.

This piece of code is extracted from an actual script:

```tcsh
seqret -sequence ${readfile}:\*_s1_p0_${read_id}_\* -outseq p0.1_${read_id}.fasta
union -sequence p0.1_${read_id}.fasta -outseq p0.1_${read_id}_concat.fasta
infoseq -noheading -only -length -sequence p0.1_${read_id}.fasta | sed -e 's/ .*$//' > p0.1_${read_id}_lengths.txt
infoseq -noheading -only -name -length -sequence p0.1_${read_id}.fasta | awk -F ' +' '{c+=$2;print c}' > p0.1_${read_id}_positions.txt

set numseqs = `egrep -c '>' p0.1_${read_id}.fasta`
set length = `infoseq -noheading -only -length p0.1_${read_id}_concat.fasta -stdout -auto`

# create a HDF5 file with all metrics for a given read
cp $datadir/$nozmwmetricsfile p0.1_${read_id}_nozmwmetrics.bax.dump
sed -i -e 's/HDF5.*/HDF5 \"p0.1_'${read_id}'.bax.h5\" {/' p0.1_${read_id}_nozmwmetrics.bax.dump
rm -f p0.1_${read_id}.bax.dump; touch p0.1_${read_id}.bax.dump
awk -v 'num='$numseqs -v 'RS=XXX' 'BEGIN {printf "         ATTRIBUTE \"CountStored\" {\n               DATATYPE  H5T_STD_I32LE\n               DATASPACE  SCALAR
/usr/bin/perl -ne '$attribute=`cat extractpacbiodata_'${read_id}'_CountStored_attribute.txt`;$_=~s/ATTRIBUTE \"CountStored\".*/$attribute/;print $_;' p0.1_${rea
mv -f p0.1_${read_id}.bax.dump p0.1_${read_id}_nozmwmetrics.bax.dump
```

To me, this piece of code has several important disadvantages.

First, it is very difficult to read.
To understand what it does step-by-step, one would have to read the manual of
every single third-party tool that is used: `seqret`, `infoseq`, etc, as well
has being skilled in classic unix such as `sed` and `awk`, and programming
languages (`perl`).

Second, some tools may not have been written in a unix traditional way, i.e.
writting the output on the standard output but whether in an output file.
This means that several output temporary files are written as the script is
executed, drastically reducing the performances.

So, sometimes, it may be critical to reinvent the wheel and code e.g. a Python
script that will not use already written tools allowing it to deal with data
on-the-fly (meaning in memory).