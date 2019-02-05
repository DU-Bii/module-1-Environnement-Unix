# Exemple de mise en pratique pour analyse de données RNAseq
# Lancement des analyses sur le cluster NNCR en utilisant des scripts bash

## Connnection au cluster NNCR IFB et chargement des environnements nécessaires

> > ```bash
> > $ ssh <username>@core.cluster.france-bioinformatique.fr
> > ```

> > ```bash
> > module load conda
> > source activate eba_rnaseq_ref-2018
> >```

## Le jeu de données

On dispose de 2 échantillons de reads pairés et de 2 répliques par échantillons (soient 4 échantillons et 8 fichiers, les paires de reads étant stockées dans 2 fichiers séparés) :

> > ```bash
> > $ ls  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/*.fastq
> >  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR1_1.fastq
> >  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR1_2.fastq
> >  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR2_1.fastq
> >  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/dFNR2_2.fastq
> >  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT1_1.fastq
> >  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT1_2.fastq
> >  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT2_1.fastq
> >  /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq/WT2_2.fastq
> > 
> >```

## Première étape : contrôle qualité

Nous allons utiliser un premier script bash pour lancer sur le cluster de l'IFB 8 calculs fastqc correspondant aux 8 fichiers à analyser

> > ```bash
> >  $ cat fastqc_myfiles.sh  
> >  #! /bin/bash  

> >  data=$(ls $1/*.fastq)  

> >  for fastqc_file in ${data[@]}   
> >  do  
> >    srun fastqc --quiet  $fastqc_file -o ./fastqc-results/ 2> fastqc.err  &  
> >  done  

Pour lance ce script je vais écrire la commande  

> > ```bash
> >   ./fastqc_myfiles.sh /shared/projects/du_bii_2019/data/study_cases/Escherichia_coli/bacterial-regulons_myers_2013/RNA-seq/fastq
> >



