template: title

# The SLURM Batch system

---
layout: true
name: slurm
template: content

# The SLURM Batch System

---
template: slurm

## What is a Batch system

The IFB cluster uses a Batch system software, a scheduler, for managing and allocating resources.

--

There are different batch systems, e.g.:

* Sun Grid Engine (SGE)
* Load Sharing Facility (LSF)
* TORQue
* SLURM

--

.center.callout.callout-success[**The IFB cluster is based on SLURM.**]

---
template: slurm

## SLURM components

A cluster based on SLURM is composed of several type of nodes:

--

* **Submission node**: this is the node where user connect to use the cluster (core.cluster.france-bioinformatique)

.center.callout.callout-warning[You should NEVER run programs on the submission node]

--

* **Compute nodes**: these are the nodes where you jobs get executed (lots of CPU and RAM)

--

* **Administrative node**: this is the node dedicated to the cluster management (you should not care about them)

--

* **Storage nodes**: these nodes are used to made your data available all over the cluster

---
template: slurm

## SLURM components

.center[![SLURM components](images/slurm_components.png)]

---
template: slurm

## Basic SLURM concepts

**Account**: A logical group of users

Resource consumption is associated with an account.<br/>
On the IFB cluster an account is created for each project.<br/>
You may have access to multiple accounts (if you have several projects).<br/>
Your first project will be your default account.

--

**Resources**: nodes, CPUs, memory

--

**Partition**: logical group of nodes

They are different partitions on the IFB cluster:
* `fast`: limited to 1 day - 71 nodes available
* `long`: limited to 30 days - 21 nodes available
* `bigmem`: limited to 60 days - 1 node available - On demand
* `training`: limited to 1 day - 5 nodes available - On demand

The default partition is `fast`.

---
template: slurm

## Basic SLURM concepts

### Job

**User's point of view**: a calculation or data analysis

It could be a single program or a full pipeline (a succession of programs).

**Slurm's point of view**: an allocation of resources

--

### Job steps

The processes that actually do the real work

--

### Process/Task

An instance of a computer program executed by one or many threads

--

### Thread

A thread of execution is the smallest sequence of programmed instructions that can be executed

---
template: slurm

## Basic SLURM concepts

.center[![A job](images/a_job.drawio.png)]

---
template: slurm

## Basic SLURM concepts

.center[![A job](images/processes.drawio.png)]

---
template: slurm

## Basic SLURM concepts

.center[![A job](images/threads.drawio.png)]

---
template: slurm

## Basic SLURM concepts

.center[![A job](images/multijobs.drawio.png)]

---
template: slurm

## Check the cluster state

### `sinfo`

This command let you get information about the current load of the cluster

`sinfo -Nl` : get a list of all nodes and there state

*idle* : no job currently running on this node<br/>
*mixed* : node ressources partially used<br/>
*allocated* : all node ressources are used

`sinfo -N -o "%15N %10P %.11T %.4c %.6O %.6m %.6e %20E"` : get detailed load information for each node

---
template: slurm

## Submitting a job

In order to submit a job on the cluster you have to :
* Write a shell script
* Submit that script to SLURM

---
template: slurm

## Submitting a job : write a shell script

A shell script is a simple text file that contains the list of command that should be executed to perform the job.

* Must start with shebang (#!) followed by the path of the interpreter
  * `#! /bin/bash`
  * `#! /bin/zsh`

* Contains two sections
  * Reservation section : a list of SLURM options to set your resource reservation
  * Script section : the shell script itself

---
template: slurm

## Submitting a job : write a shell script

### Example script

```bash
#!/bin/bash

#SBATCH --mem=3GB

tar xvzf my_data.tar.gz
```

--

.center[![A job](images/bowtie2.drawio.png)]

---
template: slurm

## Submitting a job : using `sbatch`

```
sbatch myscript.sh
```

`sbatch` returns the job ID of the newly created job.

The job will be placed in the jobs queue till the resources required to run the job are available.

By default, all output of the job are redirected to a file called slurm-<jobid>.out in your current folder.

You can use the `sbatch` paramater `-o` and `-e` to change the standard output and error output default location.
When defining the file name you can use special characters like :<br/>
`%j` : jobid of the running job<br/>
`%x` : job name

Read the sbatch documentation for more remplacement symbols.

---
template: slurm

## Exercice 3 : run a simple job

* Create a shell script for SLURM, that will :
  * Print the name of the current compute node
  * Print the current working directory path
  * List the content of /tmp
* Submit the script and ask SLURM to write the job result in a file called `result-<jobid>.txt` where `<jobid>` is the jobid of the job
* Check the result of your job
* How to make sure the `result-<jobid>.txt` file name pattern will be used each time the job is submitted to the cluster ?

Hint : Do you know the `hostname` command ?

---
template: slurm


### Exercice 3 : run a simple job

* Create a shell script for SLURM, that will :
  * Print the name of the current compute node
  * Print the current working directory path
  * List the content of /tmp

```
#! /bin/bash

hostname
pwd
ls /tmp
```

---
template: slurm

## Exercice 3 : run a simple job

* Create a shell script for SLURM
* Submit the script and ask SLURM to write the job result in a file called `result-<jobid>.txt` where `<jobid>` is the jobid of the job

```
sbatch -o "result-%j.txt" my_script.sh
```

---
template: slurm

## Exercice 3 : run a simple job

* Create a shell script for SLURM
* Submit the script and ask SLURM to write the job result in a file called `result-<jobid>.txt` where `<jobid>` is the jobid of the job
* Check the result of your job

```
cat result-5251114.txt
```

or

```
less result-5251114.txt
```

or

```
more result-5251114.txt
```

---
template: slurm

## Exercice 3 : run a simple job

* Create a shell script for SLURM
* Submit the script and ask SLURM to write the job result in a file called `result-<jobid>.txt` where `<jobid>` is the jobid of the job
* Check the result of your job
* How to make sure the `result-<jobid>.txt` file name pattern will be used each time the job is submitted to the cluster ?

```
#! /bin/bash

#SBATCH -o "result-%j.txt"

hostname
pwd
ls /tmp
```

---
template: slurm

## Job control

View ALL jobs in the cluster queue:
```
squeue
```

View only my jobs in the cluster queue:
```
squeue -u <username>
```

View only my running jobs in the cluster queue :
```
squeue -u <username> -t R
```

---
template: slurm

## Job control

`sacct` lets you query the SLURM database to get detailed informations about your jobs

View basic informations about your jobs for the current day:

```
sacct
```

View basic information about your jobs within a time period:

```
sacct -S 2020-01-01 -E 2019-06-30
```

View CPU time and memory consumption the job with id `<jobid>`:

```
sacct --format=JobID,JobName,CPUTime,MaxRSS -j <jobid>
```

Learn more about format options :

```
sacct --helpformat
```

---
template: slurm

## Job control

***Cancel a job***

`scancel <jobid>`: Cancel job with id `<jobid>`

`scancel -u <user>`: Cancel all jobs from user `<user>`

`scancel -n <jobname>`: Cancel all jobs with name `<jobname>`

`scancel -u <user> -p <partition> -t <state>`: Cancel all jobs from user `<user>`, in partition `<partition>`, in state `<state>`

---
template: slurm

## Exercice 4: sorting numbers

* Run a job that generate a file with 10 millions random numbers between 1 and 10 billion and then sort them
* How long does it take to run the whole job
* In your opinion which part of the job is taking the most time

Hint: Do you know the `shuf` and `sort` commands ?

---
template: slurm

## Exercice 4: sorting numbers

* Run a job that generate a file with 10 millions random numbers between 1 and 10 billion and then sort them

Create a file called `random-numbers.sh`
```
#! /bin/bash

shuf -i 1-10000000000 -n 10000000 -r -o numbers.txt
sort -g -o numbers.sorted.txt numbers.txt
```

Let's run it:
```
$ sbatch random-numbers.sh
Submitted batch job 5251251
```

---
template: slurm

## Exercice 4: sorting numbers

* Run a job that generate a file with 10 millions random numbers between 1 and 10 billion and then sort them
* How long does it take to run the whole job

```
$ sacct --format=JobID,JobName,Elapsed,State -j 5251251
       JobID    JobName    Elapsed      State
------------ ---------- ---------- ----------
5251251      random.sb+   00:00:22  COMPLETED
5251251.bat+      batch   00:00:22  COMPLETED
```

---
template: slurm

## Exercice 4: sorting numbers

* Run a job that generate a file with 10 millions random numbers between 1 and 10 billion and then sort them
* How long does it take to run the whole job
* In your opinion which part of the job is taking the most time

.center[![What ?](https://media.giphy.com/media/pPhyAv5t9V8djyRFJH/giphy-downsized.gif)]

---
template: slurm

## Defining job steps

The `srun` command let you define job steps inside a job script.<br/>
You just have to prepend your command with `srun ` to make it a job step.

By default a job step gets all the resources reserved for the job but each job step can use part of or all these resources.

Each job step is tracked independently within a job so you can get detailed stats in term of resource usage and duration for each job step.

There is a special job step call `batch` that correspond to all part of your job script that are not in a job step (prepended with `srun`)

```bash
#!/bin/bash

#SBATCH --mem=3GB

srun tar xvzf my_data.tar.gz
```

---
template: slurm

## Exercice 5: sorting numbers study

* Modify your previous script (`random-numbers.sh`) to define job steps
* Which part of the job is taking the most time ?

---
template: slurm

## Exercice 5: sorting numbers study

* Modify your previous script (`random-numbers.sh`) to define job steps

```
#! /bin/bash

srun shuf -i 1-10000000000 -n 10000000 -r -o numbers.txt
srun sort -g -o numbers.sorted.txt numbers.txt
```

---
template: slurm

## Exercice 5: sorting numbers study

* Modify your previous script (`random-numbers.sh`) to define job steps
* Which part of the job is taking the most time ?

```
$ sbatch random-numbers.sh
Submitted batch job 5251623
```

```
$ sacct --format=JobID,JobName,Elapsed,State -j 5251623
       JobID    JobName    CPUTime    Elapsed      State
------------ ---------- ---------- ---------- ----------
5251623      random-nu+   00:00:22   00:00:58  COMPLETED
5251623.bat+      batch   00:00:2   00:00:58  COMPLETED
5251623.0          shuf   00:00:03   00:00:05  COMPLETED
5251623.1          sort   00:00:19   00:00:52  COMPLETED
```

---
template: slurm

## Exercice 5: sorting numbers study

* Modify your previous script (`random-numbers.sh`) to define job steps
* Which part of the job is taking the most time ?

.center[**Sorting takes the most time !**]

.center[![Boom](https://media.giphy.com/media/3o7qDSOvfaCO9b3MlO/giphy-downsized.gif)]

---
template: slurm

_by the way, did you know..._

## You can use `srun` directly on the command line

Using `srun` outside a sbatch script is an easy way to run command on the cluster interactively :
* Outputs are returned to the terminal
* You have to wait until the job is completed before starting a new job
* It works with **ANY command**

Example :
```
$ srun tar cvzf stargate-results.tar.gz /shared/projects/stargate/results
```

_Slurm will create a job (reservation) and execute the command `tar` within this reservation. All commands output are returned to the terminal._

`srun` and `sbatch` take mostly the same parameters.

---
template: slurm

## Resources reservation

### CPUs  *(1 CPU = 1 hyperthreaded core)*

`--nodes/-N`: number of nodes (default is 1)

`--ntasks/-n`: number of tasks or process (default is 1)

`--cpus-per-task/-c`: number of CPU per task (default is 1)

**Examples**<br/>
```
$ srun hostname
cpu-node-1
$ srun --ntasks 2 hostname
cpu-node-1
cpu-node-1
$ srun --nodes 2 --ntasks 2 hostname
cpu-node-1
cpu-node-2
```

---
template: slurm

### Memory

`--mem`: memory for the whole job

`--mem-per-cpu`: memory per CPU


---
template: slurm

## Job priority

Job priority is determined according to several criteria:
Age: the amount of time the job has been on hold. This criterion will have its maximum value after 7 days.
Fair-Share: the difference between the amount of computing resources promised and the amount of resources used. Valid only for the last 14 days.
Job Size: the number of nodes or CPUs requested (large jobs have priority)

For each job, SLURM calculates a value between 0 and 1 for each criterion. Then a ponderation is applied according to the cluster configuration.

The `sprio` command allows you to consult the application of the priority criteria.

---

template: slurm

## Exercice 6 : sorting numbers... faster

* Modify the `sort` step to use multiple cores
* Check that the job is running faster ?
* Can you image other ways to make this job faster ?

---
template: slurm

## Exercice 6 : sorting numbers... faster

* Modify the `sort` step to use multiple cores

```
#! /bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32

srun --cpus-per-task=1 shuf -i 1-10000000000 -n 10000000 -r -o numbers.txt
srun sort -g --parallel=32 -o numbers.sorted.txt numbers.txt
```

---
template: slurm

## Exercice 6 : sorting numbers... faster

* Modify the `sort` step to use multiple cores
* Check that the job is running faster ?

```
$ sbatch random-numbers.sh
Submitted batch job 5263299
```

```
$ sacct --format=JobID,JobName,NCPUS,CPUTime,Elapsed,State -j 5263299
       JobID    JobName      NCPUS    CPUTime    Elapsed      State
------------ ---------- ---------- ---------- ---------- ----------
5263299      random-nu+         32   00:09:04   00:00:17  COMPLETED
5263299.bat+      batch         32   00:09:04   00:00:17  COMPLETED
5263299.0          shuf          1   00:00:04   00:00:04  COMPLETED
5263299.1          sort         32   00:06:56   00:00:13  COMPLETED
```

---
template: slurm

## Modify a job
<br/>
.callout.callout-warning[Works only for pending jobs]
<br/><br/>

`scontrol update jobid=<jobid> partition=<other_partition> account=<other_account> numcpus=<number_of_total_cpus>`

---
template: slurm

## Prevent a job from starting

<br/>
.callout.callout-warning[Only if it is pending]
<br/><br/>

`scontrol hold <jobid>`

`scontrol release <jobid>`

---

## Dependencies between jobs

Slurm lets you define dependencies between jobs in order to manage task ordering.

`sbatch --dependency=afterok:<other_jobid> <script>`<br/>
*Start this job only after `<other_jobid>` has finished successfully.*

`sbatch --dependency=afternotok:<other_jobid> <script>`<br/>
*Start this job only after `<other_jobid>` has failed.*

`sbatch --dependency=after:<other_jobid> <script>`<br/>
*Start this job only after `<other_jobid>` has started (control starting order)*

`sbatch --dependency=afterany:<other_jobid> <script>`<br/>
*Start this job only after `<other_jobid>` has finished (what ever exit code)*

---
template: slurm
layout: true
name: exercise-dependency

## Quizz

Imagine we start the following pipeline:
```
$ sbatch data_download.sh
Submitted batch job 1
$ sbatch --dependency=afterok:1 data_analysis.sh
Submitted batch job 2
```

---

template: exercise-dependency

**Q1: After job `1` has started, what will be the status of job `2` ?**

--

Job `2` will be in `pending` status because it is waiting for job `1` to finish successfully.

--

**Q2: How can you check the status of job `2` ?**

--

```
$ squeue -j 2
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    2      fast data_ana  jseiler PD       0:00      1 cpu-node1(Dependency)
```
---

template: exercise-dependency

We realize that we targetted the wrong data in the first job.

**Q3: How can you cancel job `1` ?**

--

```
$ scancel 1
```

--

**Q4: What will be the status of job `2` ?**

Job `2` is still `pending`.

--

```
$ squeue
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    2      fast data_ana  jseiler PD       0:00      1 cpu-node1(DependencyNeverSatisfied)
```

---

template: exercise-dependency

We have fixed the `data_download.sh` script.

**Q5: How can we restart the script and update the dependency on job `2` ?**

--

```
$ sbatch --hold data_download.sh
Submitted batch job 3
$ scontrol update jobid=2 dependency=afterok:3
$ scontrol release 3
$ squeue
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    2      fast data_ana  jseiler PD       0:00      1 cpu-node1(Dependency)
    3      fast data_dow  jseiler  R       0:33      1 cpu-node1
```

---
template: slurm

## How to parallelize ?

SLURM offers several way to parallelize your processing.


**Multithreading**<br/>
*One process can run on several CPU using threads*

- TopHat: `-p` / `--num-threads`
- Bowtie2: `-p` / `--threads`
- Trinity: `--CPU`
- sort: `--parallel`

<br/>
.callout.callout-warning[Multithreading is not possible with all software]

<br/><br/>

**Multiprocessing (or multitasking)**<br/>
*Several process of the same software can run in parallel*

---

template: slurm

## Common parallelization patterns

### Input data splitting

.center[![Input data splitting pattern](images/input_splitting_pattern.drawio.png)]

---

template: slurm

## Common parallelization patterns

### Variables exploration

.center[![Variable exploration pattern](images/multiparams_pattern.drawio.png)]

---

template: slurm

## Using `--array`

Example:

.left-column[
`fastqc.sh`
```bash
#!/bin/bash
#SBATCH --array=0-29  # 30 jobs

INPUTS=(../fastqc/*.fq.gz)

srun fastqc ${INPUTS[$SLURM_ARRAY_TASK_ID]}
```

```
$ sbatch fastqc.sh
Submitted batch job 3161045
```

`--array=1,2,4,8`<br/>
`--array=0,100:5 # equivalent to 5,10,15,20...`<br/>
`--array=1-50000%200 # 200 jobs max at the time`

]

--

.right-column[
`multiqc.sh`
```bash
#!/bin/bash

srun multiqc .

```

```
$ sbatch --dependency=afterok:3161045 multiqc.sh
```
]

---
template: slurm

## Exercice 7: multiple numbers sorting

* Run a job array that generate 10 files with 10 millions random numbers between 1 and 10 billion and then sort them

--

Let's update our `random-numbers.sh` script:

```
#! /bin/bash

#SBATCH --array=1-10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32

srun --cpus-per-task=1 shuf -i 1-10000000000 -n 10000000 -r -o numbers.$SLURM_ARRAY_TASK_ID.txt
srun sort -g --parallel=32 -o numbers.$SLURM_ARRAY_TASK_ID.sorted.txt numbers.$SLURM_ARRAY_TASK_ID.txt
```

Run the job array:
```
$ sbatch random-numbers.sh
```
