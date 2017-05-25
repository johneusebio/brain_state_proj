#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -M hpc3586@localhost
#$ -m be
#$ -o logs/grp_STD.out
#$ -e logs/grp_STD.err
#$ -q abaqus.q

TOP_DIR=$1 						# here you enter in the group directory
COND=$2    						# enter the condition name
FD=$3      						# enter frame-wise displacement threshold
DVARS=$4   						# enter DVARS threshold
RM=$5      						# use "UNION" or "INTERSECT" of FD & DVARS

DATE=$(date +%y-%m-%d)
mkdir -p logs/$DATE

subj_ls=($(ls $TOP_DIR))

for subj in ${subj_ls[@]}; do
	SUBJ_DIR=$TOP_DIR/$subj
	qsub -q abaqus.q -N pp_$subj -o logs/$DATE/pp_$subj.out -e logs/$DATE/pp_$subj.err preproc_wrapper.sh $SUBJ_DIR $COND $FD $DVARS $RM
done