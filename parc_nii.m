function parc_nii(file_mask,file_out,img_parc)
% Save the parcellation results into .nii file. Usually the type of img in
% the maskfile is single or int16, but the type of label is double, so we
% should transform the data type before saving the result to the .nii file.
% 2014-10-21 20:51:07

nii=load_untouch_nii(file_mask);
nii.img=cast(img_parc,class(nii.img));
save_untouch_nii(nii,file_out);