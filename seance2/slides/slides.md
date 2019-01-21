class: center, middle

# IFB High Performance computing usage

## DU Bii 2019

Julien Seiler (julien.seiler@igbmc.fr)<br/>
Jacques van Helden (jacques.van-helden@univ-amu.fr)

.footer[
https://github.com/DU-Bii/module-1-Environnement-Unix
]

---

layout: true
name: title
class: middle

.footer[
DU Bii 2019
]

---

layout: true
name: content

.footer[
DU Bii 2019
]

---

template: content

# What are we going to talk about today?

* What is HPC cluster and what is it used for ?
* How to connect to the IFB cluster
* The SLURM Batch system
* Use "module" to load tools
* Use "conda" to install more software

---

template: title

# What is HPC cluster and what is it used for ?

---

template: content

# How does a computer work ?

## one or more chips .fas.fa-microchip[]

A chip (or microprecessor) is responsible for executing elementary instructions requested by the software

--

## RAM (Random access memory) .fas.fa-memory[]

RAM is used by the chip to process data (a personal computer has between 4 to 8 GB of RAM)

--

## storage space .fas.fa-hdd[]

The storage space is used to keep huge amount of data in a more permanent way (a personal computer has an average of one TB of storage space)

---

# Bit or Byte ?

A bit is **a single** binary data : 0 or 1

A byte is made of **8 bits** : 1 byte (B) = 8 bits (b)

1 Terabyte (T**B**) = 1000 Gigabytes (G**B**) = 1e+6 Megabytes (MB) = 8 000 000 Mégabits (M**b**)

---

# How does a computer work ?

## .fas.fa-microchip[] .fas.fa-memory[] .fas.fa-hdd[]

A personnal computer has enough resources to let you run a lot of tasks like **browsing the Internet**, **work with spreadsheet** or **textprocessing software**. Some personnal computers have even enough resources to let **process videos** or **play 3D videogames**.

--

## .fas.fa-microchip[] .fas.fa-microchip[] .fas.fa-microchip[] .fas.fa-microchip[]  .fas.fa-memory[] .fas.fa-memory[] .fas.fa-memory[]  .fas.fa-hdd[] .fas.fa-hdd[]

However, personal computer are not powerful enough to run **massive data analysis programs**. Indeed, these programs need a huge number of processing unit (10 to 100), huge amount of RAM (100 GB for some programs) and large storage space for data (several TB).<br/><br/>

--

.callout.callout-success[Massive data analysis requires a High Performance Computing (HPC) cluster]

---

# What is a HPC cluster?

A set of big computers connected together that can be consider as a single system.

A HPC cluster is usually located in a "datacenter". It a dedicated room providing all conditions required by HPC in terms of temperature, humidity, power supply and physical security.

.center[![Bluegene](images/bluegene.jpg)]

---

# A datacenter is composed of racks

.center[![Racks](images/racks.jpg)]

---

# Each rack can hold several computers

.center[![Computers](images/computers.jpg)]

---

# Rear view

.center[![Rear](images/rear.jpg)]

---

# More hardware concerns

.center[
## A node = a physical machine

Each physical machine has one **motherboard**

.center[![Motherboard](images/motherboard.jpg)]

This motherboard has 2 **sockets** to plug **microprocessors**.<br/>
A microprocessor is a **multicore** technology.
]
---

class: center

# Do not confuse Microprocessor and Core

A microprocessor is a **physical chip**.

![Microprocessor](images/microprocessor.jpg)

Core = CPU = Central Processing **Unit**

15 to 20 years ago = 1 microprocessor = 1 core<br/><br/>

.callout.callout-danger[THI IS NOT TRUE ANYMORE]

---

class: center

# Do not confuse Microprocessor and Core

On the IFB HPC Cluster :

1 node = 2 sockets = 2 microprocessors = 2 x 14 cores = 28 CPU<br/><br/>

.callout.callout-info[A HPC cluster can be seen has a pool of cores.]

---

# Some HPC clusters in France

.pure-table.pure-table-bordered.smaller-font[
Cluster | Datacenter location | Cores | RAM (in GB) | Storage space (en TB) | Access modality
--- | --- | --- | --- | --- | ---
IFB Core | IDRIS - Orsay | 2 000 | 20 008 | 400 | Open to all academic biologists and bioinformaticians
GENOTOUL | Toulouse | 3 064 | 34 304 | 3 000 | Open to all academic biologists and bioinformaticians
CINES OCCIGEN | Montpellier | 85 824 | 202 000 | 8 000 | On call for project
]

---

# How to access a HPC cluster?

Only the engineers in charge of maintenance of the cluster are authorized to enter the datacenter. Thus, **it is not possible to use these computers directly using a keyboard and a screen**. It is necessary to connect to it through a **computer network** such as the Internet.

To ensure that resources (nodes, cores, memory) are properly distributed among their users according to their needs, a software called a **Batch system** allows users to **book and access resources**. It is through this software that you can access one or more computers on the HPC cluster.

---

# What do I need to know to use a HPC cluster ?

## Basic Unix

There is no graphical user interface on a HPC cluster

## How to connect to a remote host through the network

Your personnal computer need to get connected to the cluster !

## How to use a Batch system

One connected to the cluster, you need to learn how to submit compute job

---

template: title

# Connect to a remote host through the network

---

template: content

# What is a shell?

A shell is a **software interface** that allows a user to interact with a computer or server by executing different commands that will return information.

```bash
$ pwd
/shared/home/jseiler
$ ls
projets     toto.txt     script.sh
$ cd projets
$ ls
mission-to-mars      rama-II       time-travel
```

The shell allows dialogue with a local workstation: one is physically present in the same room as the machine.

---

# SSH : the remote shell

To interact with a remote computer you need :
* A communication support : computer **network** like Internet
* A communication protocol : **SSH**

SSH (for Secure SHell) is the most commonly used protocol for establishing dialogue and launching commands on a remote machine.

---

# SSH : the remote shell

SSH need two parameters to run :
* The name or IP of the remote computer
* A user credential (username + password)

Under Linux or Mac, you can use SSH from the Terminal/Console application :

```bash
$ ssh <username>@<remote-host-name>
```

.callout.callout-info[
Under Windows, you can use a Terminal applications like PuTTY or MobaXterm.
]

.callout.callout-warning[
Attention, it is not possible to communicate with **any** computer through the SSH protocol. The remote computer **must have** a running SSH service.
]

---

# SSH : the remote shell

## Connect to the IFB HPC cluster

Remote computer : core.cluster.france-bioinformatique.fr
User credential : *you received it by email*

Connect with your Terminal application :
```
$ ssh <username>@core.cluster.france-bioinformatique.fr
```
*Replace `<username>` with your username.*

You will then be asked for your password (no character are printed while on type in your password).

You are now connected to the IFB cluster submission node.

Type `exit` to close the connection.

---

# SSH : the remote shell

## Copy data remotely

SSH allows you to copy data to or from a remote computer with the `scp` command.

The syntax to copy data from your personal computer to a remote host is :
```bash
$ scp /path/to/local/file <username>@<remote-host>:/remote/destination/path
```
*Replace `<username>` with your username.*

You can also copy data from a remote host to your personal computer :
```bash
$ scp <username>@<remote-host>:/remote/path /local/path
```
*Replace `<username>` with your username.*

---

# SSH : the remote shell

## Exercise

1. Connect to `core.cluster.france-bioinformatique.fr` and retrieve the full name of the pdf document located in `/shared/space2/du-bii/data/cluster/`
2. Copy this PDF document to your local computer

---

# SSH : the remote shell

## Exercise

1. Connect to `core.cluster.france-bioinformatique.fr` and retrieve the full name of the pdf document located in `/shared/space2/du-bii/data/cluster/`

--

```bash
local $ ssh seiler@core.cluster.france-bioinformatique.fr
cluster $ ls /shared/space2/du-bii/data/cluster/
slides.pdf
```
*Replace `seilerj` with your own username (I'm not sharing my password)*

--

2. Copy this PDF document to your local computer

```bash
cluster $ exit
local $ scp seilerj@core.cluster.france-bioinformatique.fr:/shared/space2/du-bii/data/cluster/slides.pdf .
```
*Replace `seilerj` with your own username (still not sharing my password)*
