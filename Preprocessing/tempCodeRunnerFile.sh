fsl_motion_outliers -i $SUBJ_DIR/task_data/preproc/t_$COND.nii* -o $SUBJ_DIR/mot_analysis/$COND'_FD.par' -s $SUBJ_DIR/mot_analysis/$COND'_FD.val' -p $SUBJ_DIR/mot_analysis/plots/$COND'_FD' --fd --thresh=$fd_thr