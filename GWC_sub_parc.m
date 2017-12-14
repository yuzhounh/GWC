function GWC_sub_parc(iSub,iK)
% Parcellation by GWC.
% 2017-8-16 10:09:39

load sInfo.mat;
cSub=sSub(iSub);
cK=sK(iK);

% GWC
[S,Z,alpha,beta,iter_GWC,time_GWC]=GWC(iSub,iK); 

% apply Ncut and MSC on the graph S to generate parcellations
[EV,EDD,time_eigen]=Ncut_eigen(S,cK); % feature extraction by Ncut
[LG,L,iter_MSC,time_MSC]=Ncut_kway(EV,cK); % multi-class spectral clustering

% map the parcellation results from supervoxels to voxels
load(sprintf('SLIC_supervoxel/sub%05d.mat',cSub));
parc_MSC=LG;
parc_SLIC=img_parc;
parc_GWC=parc_mapback(parc_SLIC,parc_MSC);
parc_GWC=parc_renumber(parc_GWC);

% prepare for evaluation
img_parc=parc_GWC;
K=length(unique(img_parc))-1;

% save to .mat file
save(sprintf('GWC_sub_parc/sub%05d_K%d.mat',cSub,cK),'S','Z',...
    'alpha','beta','EV','EDD','parc_SLIC','parc_MSC','parc_GWC',...
    'iter_GWC','iter_MSC','time_GWC','time_eigen','time_MSC',...
    'img_parc','K');

% save to .nii file
file_mask='graymatter.nii';
file_out=sprintf('GWC_sub_parc/sub%05d_K%d.nii',cSub,cK);
parc_nii(file_mask,file_out,img_parc);