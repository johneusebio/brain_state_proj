SUBJ_DIR=$1
COND=$2
PREPROC=$3

echo '	regressing motion...'

fsl_glm -i $SUBJ_DIR/task_data/preproc/motreg_snlmt_$COND.nii* -d $SUBJ_DIR/MPEs/$COND.1D --out_res=$SUBJ_DIR/task_data/preproc/motreg_snlmt_$COND

echo '	motion scrubbing...'

fsl_glm -i $SUBJ_DIR/task_data/preproc/motreg_snlmt_$COND.nii* -d $SUBJ_DIR/mot_analysis/$COND'_CONFOUND.par' --out_res=$SUBJ_DIR/task_data/preproc/scrub_motreg_snlmt_$COND