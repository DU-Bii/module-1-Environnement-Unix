template: title

# How to access the IFB Core Cluster ?

---

# How to access the IFB Core Cluster ?

## A remote infrastructure

Only the engineers in charge of maintenance of the cluster are authorized to enter the data center.

**It is thus not possible for users to access these computers with a directly connected keyboard and a local screen**. The connection has to be managed through a **computer network** such as the Internet.

To ensure that resources (nodes, cores, memory) are properly distributed among their users according to their needs, a software called a **Batch system** allows users to **book and access resources**. It is through this software that you can access one or more computers on the HPC cluster.

---

# How to access the IFB Core Cluster ?

## What do I need to know :

* Basic Unix skills .fas.fa-check[]
* SSH .fas.fa-check[]
* How to use a Batch system

---

template: content

# How to access the IFB Core Cluster ?

## Exercice 1 : let's get connected

* Connect to the IFB Core Cluster using `ssh`
* Find the name of your current working directory
* List all the file in your current working directory including hidden files

---

# How to access the IFB Core Cluster ?

## Exercice 1 : let's get connected

* Connect to the IFB Core Cluster using `ssh`

Use your Terminal application to connect the cluster:
```shell
ssh <username>@core.cluster.france-bioinformatique.fr
```
*Replace `<username>` with your username.*

**Beware**: at the password prompt, the characters you type are not printed on the screen, for obvious security reasons.

---

template: content

# How to access the IFB Core Cluster ?

## Exercice 1 : let's get connected

* Connect to the IFB Core Cluster using `ssh`
* Find the name of your current working directory

```shell
pwd
```

The result should look like this :
```
/shared/home/jseiler
```
*Do not type this in your terminal, it is not a command ;-)*

---

template: content

# How to access the IFB Core Cluster ?

## Exercice 1 : let's get connected

* Connect to the IFB Core Cluster using `ssh`
* Find the name of your current working directory
* List all the file in your current working directory including hidden files

```shell
ls -a
```

The result should look like this :
```shell
.  ..  .bash_logout  .bash_profile  .bashrc  .emacs  .kshrc  .xemacs  .zshrc
```
*Do not type this in your terminal, it is not a command ;-)*

---

# How to access the IFB Core Cluster ?

## Exercise 2 : Copy a file

1. List the pdf document(s) located in `/shared/projects/dubii2020/data/cluster/` (on the IFB core cluster)
3. Get the full path of the pdf file(s) located there.
4. Copy the PDF document(s) to your local computer

---

# How to access the IFB Core Cluster ?

## Exercise 2 : Copy a file


1. List all files located in `/shared/projects/dubii2020/data/cluster/` (on the IFB core cluster)

```shell
cluster $ ls /shared/projects/dubii2020/data/cluster/
```

The result should look like this :
```shell
10.txt  1.txt  2.txt  3.txt  4.txt  5.txt  6.txt  7.txt  8.txt  9.txt slides.pdf
```
*Do not type this in your terminal, it is not a command ;-)*

---

# How to access the IFB Core Cluster ?

## Exercise 2 : Copy a file

1. List all files located in `/shared/projects/dubii2020/data/cluster/` (on the IFB core cluster)
2. List only the pdf files in this folder, and get the full path.

```bash
cluster $ ls /shared/projects/dubii2020/data/cluster/*.pdf
```

The result should look like this :
```shell
/shared/projects/dubii2020/data/cluster/slides.pdf
```
*Do not type this in your terminal, it is not a command ;-)*

---

# How to access the IFB Core Cluster ?

## Exercise 2 : Copy a file

1. List the pdf document(s) located in `/shared/projects/dubii2020/data/cluster/` (on the IFB core cluster)
2. Get the full path of the pdf file(s) located there.
3. Copy the PDF document(s) to your local computer

```bash
local $ scp <username>@core.cluster.france-bioinformatique.fr:/shared/projects/dubii2020/data/cluster/*.pdf .
```
*Replace `<username>` with your own username*

---

# SSH: the remote shell

## Copying data between distant computers

SSH allows you to copy data to or from a remote computer with the `scp` command.

General syntax

```bash
scp [source_location] [target_location]
```

* From the local computer to a remote host (Note: *Replace `<username>` with your username.*)


```bash
$ scp /path/to/local/file <username>@<remote-host>:/remote/destination/path
```

* From a remote host to the local computer

```bash
$ scp <username>@<remote-host>:/remote/path /local/path
```
