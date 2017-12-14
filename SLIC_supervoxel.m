function SLIC_supervoxel(iSub)
% Generate supervoxels by SLIC. These supervoxels will be merged by GWC to
% generate clusters. 
% 2016-4-8 16:05:41 

tic;
load sInfo.mat;
load parc_graymatter.mat;

cK=1000; % fix the number of supervoxels
cSub=sSub(iSub);

% load the original image data
load(sprintf('data/sub%05d.mat',cSub));

% apply SLIC on the original image data
m=10; % the tuning parameter
[label,iter,~]=SLIC(img_gray,m,cK);
tmp=zeros(siz);
tmp(msk_gray)=label;
img_parc=tmp;
img_parc=parc_relabel(img_parc); % relabel
K=length(unique(img_parc(:)))-1; % actual cluster number

% save to .mat file
time=toc/3600;
save(sprintf('SLIC_supervoxel/sub%05d.mat',cSub),'img_parc','K','iter','time');
fprintf('Time to do parcellation: %0.2f hours. \n',time);

% save to .nii file
file_mask='graymatter.nii';
file_out=sprintf('SLIC_supervoxel/sub%05d.nii',cSub);
parc_nii(file_mask,file_out,img_parc);