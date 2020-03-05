template: title

# Facilitating file transfer


---

template: content

# Exercise: transferring files with filezilla

* On your own machine, create a directory named `DU-Bii_files` and open this directory with Filezilla.

* With Filezilla, open a connection to the IFB core cluster, based on the parameters of the `ssh` commands seen in the previous slides.

* Transfer the full content of the folder `/shared/mfs/data/projects/du_bii_2019/data/cluster` from the remote host to your computer.

* At this stage, the teacher will do a small change in one file of this directory.

* Re-do the transfer, and choose appropriate options to only import files that are newer on the server than on your local copy.



---

template: content

# Solution: transferring files with Filezilla

* Open the [Filezilla](https://filezilla-project.org/) application

* Enter the parameters (Host, Username, Password) to establish a connection to IFB core cluster.

* The Port should be set to 22 for (this is the classical port for ***SFTP***, ***Secure File Transfer Protocol***).

* Click `Quickconnect`. At your first connection, Filezilla will ask you to confirm that you trust this host. Check *"Always trust this host"* and click **OK**.

* On the remote host, find the path to the shared data (`/shared/mfs/data/projects/du_bii_2019/data/cluster`).

* ***The rest will be shown as a demo during the course. ***


---


template: title

# Advanced file transfer with `rsync`

---

template: content

# Tutorial: rsync

The command `rsync` us used to synchronize files and directories between two locations. Both the source and target locations can be either local or remote.

* On your local computer, run the command `man rsync` and count the number of pages of the manual.

    - **Tip:** when the `man` command has started, press `space bar` to display the next page. If you are bored, you can press `q` to quit.

* A quick approach: instead of reading the `rsync` manual (which is generally recommanded before using a program) we will provide some hints for the usual parameters.

---

template: content

# Tutorial: using rsync to get file lists

When `rsync` is used with a single location (remote or local), it list the files found at that location.


* Get the list of files in your account on the IFB core cluster.

```bash
rsync <username>@core.cluster.france-bioinformatique.fr:
```
*Replace `<username>` with your own username*

**Important:** the column symbol `:` is necessary to tell `rsync` that you are referring to a remote server. It you forget it, rsync will consider that you refer to a (non-existing) local file or folder named <username>@core.cluster.france-bioinformatique.fr

---

template: content

# Exercise: using rsync to transfer one file

1. Use rsync to list the files in the directory `/shared/projects/du_bii_2019/data/cluster/` of IFB core cluster.

2. Use rsync to transfer the file `slides.pdf` from IFB core cluster to your working directory (**Note:** the current working directory is denoted by a simple dot `.`). Add some relevant options to `rsync`.

    - `-v` to get some verbosity (the program informs you about the progress of the task)
    - `-u` for **update**, i.e. transfer files only of they are more recent on the source (in this case the file on thecore cluster) than on the target (in this case your local copy of this file).

---

template: content

# Solution: using rsync to transfer one file

1. Use rsync to list the files in the directory `/shared/projects/du_bii_2019/data/cluster/` of IFB core cluster.

```bash
rsync jvanhelden@core.cluster.france-bioinformatique.fr:/shared/projects/du_bii_2019/data/cluster/
```

2. Use rsync to transfer the file `slides.pdf` from IFB core cluster to your working directory (**Note:** the current working directory is denoted by a simple dot `.`).

```bash
rsync -v -u jvanhelden@core.cluster.france-bioinformatique.fr:/shared/projects/du_bii_2019/data/cluster/slides.pdf .

## check that the file is well on the local working directory
ls -l .
```

---

template: content

# Exercise: transferring a full directory with rsync

* Use rsync to transfer the directory `/shared/projects/du_bii_2019/data/cluster/` from IFB core cluster to the local directory.  Adapt the following options:

    - `-r` to transfer recursively all the sub-directories of the source directory
    - `-u` to only transfer files
    - `-p` to preserve file ownership
    - `-t` to preserve file "time" (last modification date)
    - `-v` to get some verbosity


---

template: content

# Solution: transferring a full directory with rsync


* Use rsync to copy the directory `/shared/projects/du_bii_2019/data/cluster/` from IFB core cluster to the local directory.  

```bash
rsync -ruptv jvanhelden@core.cluster.france-bioinformatique.fr:/shared/projects/du_bii_2019/data/cluster .

## check that the file is well on the local working directory
ls -l .
ls -l cluster
```

* Re-run the same command and check if new files are transferred.

```bash
rsync -ruptv jvanhelden@core.cluster.france-bioinformatique.fr:/shared/projects/du_bii_2019/data/cluster .
```

---

template: content

# Project folders on the IFB core cloud

On the IFB cloud, big data files should not be stored in your home folder  but in a specific project folder. Project folders can bne either individua , or shared by a team (they can be configured on demand).

For this training (2019 session of the DU-Bii), we prepared an individual project folder for each trainee, which can only be read and written by the trainee and his/her tutor.

`/shared/projects/du_bii_2019/<username>/`

---

template: content

# Exercise: transferring files to your project folder


1. Open an `ssh` connection to the cluster.

2. Go to your project folder, check its contents and the disk space it occupies. Also check the total and available space on the disk that holds your project folder.

    **Tips: **

    - `cd` : change directory
    - `ls` : list
    - `du` : disk usage
    - `df` : disk free

3. Open a separate terminal window to run commands on your local machine. .
4. In the previous exercise, we transferred the folder `cluster` from the shared data folder of the cluster to your local folder.  In your local terminal, use `rsync` to transfer this fodler to your personal project folder on the cluster.

5. In the terminal with your ssh session to the cluster, check that the files were correctly transferred. Also check the disk space used by the newly transferred folder (`cluster`).


---

template: title

# Homework for friday

---

template: content

# Homework: transfer your data files to your project folder

* Open an ssh connection to IFB-core-cluster

* Go to your project directory (`cd`), which should be located in `/shared/projects/du_bii_2019/<username>`.

* In your project folder, create a sub-directory named `data`

* If you are going to treat different data types (e.g. RNA-seq, ChIP-seq, metabolome, proteome, metagenomics, ...), create one subdirectory for each one.

* The exercise consists in transferring to this folder at least 2 data files.


## Tips

- For this exercise, you can  use either filezilla or `rsync`.
- At this stage, no need to transfer your full datasets (this will be required later)
- If you are working with sensitive data (e.g. Human genome sequences, patient data, ...) you should keep them inside your institute. In this case, we suggest to find a dataset of the same type (but maybe belonging to a model organism) that you  will upload on the IFB-core-cluster.
