template: title

# The IFB Core Cluster

---
layout: true
name: ifb-core-cluster
template: content

# The IFB Core Cluster

---

template: ifb-core-cluster

## A short word about storage spaces

A cluster consist in a set of big computers connected together.

Each computer need to have access to the same storage spaces and storage environment.

.center[![Sotrage access](images/storage.drawio.png)]

On the IFB Core Cluster, storage spaces accessible to all compute nodes are available under `/shared`.

---

template: ifb-core-cluster

## Storage organisation

.left-column[
### Home
Your home directory is located at `/shared/home/<username>`

*Replace `<username>` with your username.*

This directory is used to store your profile informations (software settings, session informations, etc.).

When you connect to the cluster, this is the place you are located by default.
]

--

.right-column[
### Projects

Data are sorted by project in `/shared/projects`

Each user can have access to several project spaces and **several users** can work together on the same project space.

By default, each project space gets a quota of 500GB.

You can ask for a new storage space by using the IFB cluster user dashboard https://my.cluster.france-bioinformatique.fr
]

---

template: ifb-core-cluster

## Software

The IFB Core Cluster includes a large collection of bioinformatics 320 tools available as `modules`.<br/>
Some software are available in different versions and all versions are maintained on the cluster.

These software are installed through Conda packages or Singularity images.

Anyone can ask or propose a software deployment by contributing to the Cluster tools repository : https://gitlab.com/ifb-elixirfr/cluster/tools

## Banks

A wide range of banks is also available in `/shared/banks` including indexes for common softwares.

---

template: ifb-core-cluster

## Get support

.left-column[
The IFB Core Cluster team is not only providing a powerfull computing infrastructure, it is also providing **support to researchers and bioinformaticians** through a **community website** : https://community.cluster.france-bioinformatique.fr/
]

.right-column[
.center[![Community website](images/community-website.png)]
]

---

template: ifb-core-cluster

## About pricing

.left-column[
.center[![Cluster pricing](images/pricing.drawio.png)]
]

.right-column[
Currently the IFB Core Cluster is available for free to all academic users.

**In the near future (spring 2020 ?) a contribution will be requested for intensive usages on a per project basis.**

The default quota (in terms of storage space and computing hours) will be free for every project and user can buy more quota (storage or computing) for each project.

Each project request will have to include a basic data management plan.\\
A project can be shared between different users.
]
