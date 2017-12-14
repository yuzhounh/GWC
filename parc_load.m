function parc_load(iSub)
% load the image data within the graymatter mask and perform normalization
% 2017-7-7 20:40:57

load sInfo.mat;
load parc_graymatter.mat;

% load the original image data and save to .mat file
cSub=sSub(iSub);
nii=load_untouch_nii(sprintf('data/sub%05d.nii',cSub));
img_rs=double(nii.img);
num_trial=size(img_rs,4); 
img_rs=reshape(img_rs,prod(siz),num_trial);  % image data
img_gray=img_rs(ind_gray,:); 
save(sprintf('data/sub%05d.mat',cSub),'img_gray');

% normalize the data
img_gray=parc_norm(img_gray);
save(sprintf('data/sub%05d_norm.mat',cSub),'img_gray');