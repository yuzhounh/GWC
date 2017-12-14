function feature_0(iSub)
% mean coordinates
% 2017-5-15 10:59:50

load sInfo.mat;
load parc_graymatter.mat;

cSub=sSub(iSub);
load(sprintf('SLIC_supervoxel/sub%05d.mat',cSub));

labels=img_parc(ind_gray); 
sC=unique(labels); % all labels, C for cluster
nC=length(sC); % the actual cluster number
temp=zeros(nC,3);
for iC=1:nC
    cC=sC(iC);
    ix=find(img_parc==cC); % index of the current cluster
    [a,b,c]=ind2sub(siz,ix); % the coordinates in 3D space
    temp(iC,:)=mean([a,b,c]); % the mean coordinates of a supervoxel
end
fea=temp;
save(sprintf('feature_0/sub%05d',cSub),'fea');