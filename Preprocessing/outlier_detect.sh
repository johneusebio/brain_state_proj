SUBJ_DIR=$1
COND=$2
PREPROC=$3
FD=$4
DVARS=$5

echo '	computing DVARS...'

mkdir $SUBJ_DIR/mot_analysis
mkdir $SUBJ_DIR/mot_analysis/plots

NIFTI_FILE=$SUBJ_DIR/task_data/preproc/motreg_snlmt_$COND

# DVARS
fsl_motion_outliers -i $NIFTI_FILE -o $SUBJ_DIR/mot_analysis/$COND'_DVARS.par' -s $SUBJ_DIR/mot_analysis/$COND'_DVARS.val' -p $SUBJ_DIR/mot_analysis/plots/$COND'_DVARS' --dvars --nomoco --thresh=$DVARS

# FD
fsl_motion_outliers -i $SUBJ_DIR/task_data/preproc/t_$COND.nii* -o $SUBJ_DIR/mot_analysis/$COND'_FD.par' -s $SUBJ_DIR/mot_analysis/$COND'_FD.val' -p $SUBJ_DIR/mot_analysis/plots/$COND'_FD' --fd --thresh=$FD

