template: title

# Use `module` to load bioinformatics tools

---

layout: true
name: module
template: content

# Using `module`

---

template: module

## Why do we need to "load" tools ?

* Each tools need it environment (binaries, libraries, documentation, special variables)
* Each tools has its own dependencies. It is not possible to coexist all tools in the same environment.
* Reproducibility does matter: some user might need different versions of the same tool

At the IFB, the cluster community is installing all tools required by the users.<br/>

All tool deployment are based on Conda packages or Singularity images :

.center[![Packages](images/packages.drawio.png)]

To get access to a tool, you need to **load it into your environment** using a special tool called `module`.

---

template: module

## What are availables tools ?

List all available tools:

```shell
$ module avail -l
biokevlar/0.6.1                                             2019/01/23 15:12:20
blast/2.6.3                                                 2019/01/23 15:12:59
blast/2.7.1                                                 2019/01/23 15:12:59
conda                                                       2018/11/20 12:25:32
dot                                                         2018/11/20 12:25:32
eacon/0.3.4                                                 2018/11/30 10:05:25
eba_chipseq/2017                                            2019/01/23 10:45:04
eba_chipseq/2018                                            2019/01/23 11:37:12
```

---
template: module

## Loading, listing, switching, unloading

`module load blast`: Load latest version of blast available on the cluster

--

`module load blast/2.6.3`: Load version 2.6.3 of blast

--

`module list`: List tools currently loaded in your environment

--

`module switch blast/2.7.1`: Replace blast currently loaded by blast version 2.7.1

--

`module unload blast`: Unload blast from your environment

--

`module purge`: Unload all tools

---
template: module

## Creating a tool collection

Load and unload a collection of tools at once.

.left-column[
### Create a collection

Load the requested tools:

```
module load blast  # The most popular tool for sequence similarity searches
module load hmmer  # Hidden Markov Models-baset motif search
```

Save the current tools in a collection

```
module save ngs
```

### View your collection list

```
module savelist
Named collection list:
 1) ngs
```
]

.right-column[
### Load a collection

```
module restore ngs
```

### Other collection commands

`module saveshow <collection>`: consult the content of a collection

`module saverm <collection>`: suppress a collection
]
