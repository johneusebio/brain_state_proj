#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -M hpc3586@localhost
#$ -m be
#$ -q abaqus.q

SUBJ_DIR=$1
COND=$2
FD=$3
DVARS=$4
RM=$5
LOW=$6
HIGH=$7

PREPROC='/home/hpc3586/JE_packages/brain_state_proj/Preprocessing'

echo INITIALIZING PREPROCESSING --------------------

bash $PREPROC/skullstrip.sh $SUBJ_DIR $COND $PREPROC
bash $PREPROC/slicetime.sh $SUBJ_DIR $COND $PREPROC
bash $PREPROC/motcor.sh $SUBJ_DIR $COND $PREPROC
bash $PREPROC/outlier_detect.sh $SUBJ_DIR $COND $PREPROC $FD $DVARS
Rscript $PREPROC/mk_scrub_mat.R --PATH=$SUBJ_DIR --COND=$COND --RM=$RM

if [ -e $SUBJ_DIR/PASS ]; then
	PASS=TRUE
fi

if [ PASS != TRUE ]; then
	bash $PREPROC/interpolate_scrubbed.sh $SUBJ_DIR $COND $PREPROC
	bash $PREPROC/bandpass_filter.sh $SUBJ_DIR $COND $LOW $HIGH
	bash $PREPROC/mot_reg.sh $SUBJ_DIR $COND
	bash $PREPROC/normalization.sh $SUBJ_DIR $COND $PREPROC
	bash $PREPROC/nuis_reg.sh $SUBJ_DIR $COND $PREPROC
	bash $PREPROC/mot_scrubbing.sh $SUBJ_DIR $COND $PREPROC
fi

# bash $PREPROC/rm_intermediate_files.sh $SUBJ_DIR $COND

echo 'FINISHED'
