function SLIC_sub_parc(iSub,iK)
% perform individual subject level parcellation by SLIC
% 2016-4-8 16:05:41 

tic;
load sInfo.mat;
load parc_graymatter.mat;

cK=sK(iK);
cSub=sSub(iSub);

% load the original image data
load(sprintf('data/sub%05d.mat',cSub));

% apply SLIC on the original image data
m=10; % the tuning parameter
[label,iter,~]=SLIC(img_gray,m,cK);
tmp=zeros(siz);
tmp(msk_gray)=label;
img_parc=tmp;
K=length(unique(label)); % actual cluster number

% save to .mat file
time=toc/3600;
save(sprintf('SLIC_sub_parc/sub%05d_K%d.mat',cSub,cK),'img_parc','K','iter','time');
fprintf('Time to do parcellation: %0.2f hours. \n',time);

% save to .nii file
file_mask='graymatter.nii';
file_out=sprintf('SLIC_sub_parc/sub%05d_K%d.nii',cSub,cK);
parc_nii(file_mask,file_out,img_parc);