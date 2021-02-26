
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


### Using variables.

Variables are defined in a script in the same fashion as in the terminal:

```bash
# Define a variable named "VAR" with value 42
var=42

# Print the variable value
echo ${var}     # nice
echo "${var}"   # better
```

**IMPORTANT**: note the absence of spaces between the `=` sign when assigning
a value.

```bash
$ var=42   # works

$ var = 42
bash: var: command not found
```

### Storing a command's output.

A command's output can be stored in a variable for later use.

This is done by using the syntax `$(command [arguments])`.

Example:

```bash
# Store the current working directory.
workdir=$(pwd)

# Prints the current working directory.
echo "The current working directory is ${workdir}.
```


### Writing our first script: the number of unique genes in a gff.

We've seen that the command to get the number of unique genes in a gff is

```bash
cut -f 9 <GFF_NAME> | cut -d';' -f 1 | grep 'ID=gene' | sort -u | wc -l
```

Let's say we want to write a script that does that for us.

Let's create `unique-genes.bash` with a text editor and write those lines:

```bash
input_gff=~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3

n=$(cut -f 9 ${input_gff} | cut -d ";" -f 1 | grep "ID=gene" | sort -u | wc -l)
echo "Number of unique genes: ${n}"
```


### Executing a script

To execute the script we just wrote, we can execute it or "invoke" it in a terminal
simply by typing `bash unique-genes.bash`:

```bash
$ bash unique-genes.bash
Number of unique genes: 4497
```

Alternatively, we make the script executable and run it by typing
`./unique-genes.bash`.
To do this, we first need to tell the system how to execute the script, meaning
we have to tell the system it should use bash as interpreter.

This is done by putting a so-called "shebang" at the very top of the script.

Open the script and insert this as the first line: `#!/bin/bash`.

Then, we have to make the script executable: `chmod +x ./unique-genes.bash`.

```bash
$ ./unique-genes.bash
Number of unique genes: 4497
```

### Passing arguments to a script

In the script we wrote, the input file is defined by the variable `input_gff`.
It has the value `~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3`, meaning that if we want to run the
script on another file, we would have to modify the script.

So it may be conveniant to have a script that takes the input file name as an
argument.

Inside a script, the variables named by numbers represent the command-line
arguments (e.g. `${1}` is the first argument, `${10}` the tenth argument, etc).

`$#` contains the number of arguments passed to the script.

`$*` represents all the arguments passed to the script.

**Question**: adapt the `./unique-genes.bash` so that it takes the gff path
from the command-line. Then run the script:

```bash
$ ./unique-genes.bash ~/dubii/study-cases/Escherichia_coli/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3
Number of unique genes: 4497
```

> **Solution**:
> > ```bash
> > #!/bin/bash
> > 
> > input_gff=$1
> > 
> > n=$(cut -f 9 ${input_gff} | cut -d';' -f 1 | grep 'ID=gene' | sort -u | wc -l)
> > echo "Number of unique genes: ${n}"
> > ```
{:.answer}


### Repeating a series of commands for each of multiple files

Now if we want our script to work on several input files, we have to repeat
the same instructions **for each** file.

The important word here is *for each*, highlighting the concept of loop.

So, assuming that several input files were provided from the command-line, our
script becomes:

```bash
#!/bin/bash

# Store file names into a variable: $* represents all command-line arguments.
filenames=$*

for input_gff in ${filenames}
do
    n=$(cut -f 9 ${input_gff} | cut -d';' -f 1 | grep 'ID=gene' | sort -u | wc -l)
    echo "${input_gff}: ${n}"
done
```


### Checking everything is going well: tests

An test block starts with the keyword `if` and ends with `fi`
(which is `if` reversed).
In between, it is possible do add as many `else` and `elif` (the contraction
of `else if`) as necessary.

In the exemple below, we check that the number of command-line arguments
passed to the script:

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

**Question**: adapt `unique-genes.bash` so that it runs as well
whether a single or multiple files are passed to the command-line.
The script will display an error message if no input file is provided.

> **Solution**:
> > ```bash
> > #!/bin/bash
> > 
> > # The -ge operator stands for "greater or equal"
> > if [ $# -gt 1 ]; then
> >     filenames=$*
> >     for input_gff in ${filenames}
> >     do
> >         n=$(cut -f 9 ${input_gff} | cut -d';' -f 1 | grep 'ID=gene' | sort -u | wc -l)
> >         echo "${input_gff}: ${n}"
> >     done
> > elif [ $# -eq 1 ]; then
> >     input_gff=$1
> >     n=$(cut -f 9 ${input_gff} | cut -d';' -f 1 | grep 'ID=gene' | sort -u | wc -l)
> >     echo "Number of unique genes: ${n}"
> > else
> >     echo "usage: $0 <input_gff> [input_gff2..]"  # $0 is the script name
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

## A great cheatsheet

https://devhints.io/bash