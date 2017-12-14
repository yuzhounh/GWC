function feature_1(iSub)
% mean time series
% 2017-3-13 14:23:24

load sInfo.mat;
load parc_graymatter.mat;

cSub=sSub(iSub);
load(sprintf('data/sub%05d.mat',cSub));
load(sprintf('SLIC_supervoxel/sub%05d.mat',cSub));

labels=img_parc(ind_gray); % all labels
sC=unique(labels); 
nC=length(sC);
temp=zeros(nC,size(img_gray,2));
for iC=1:nC
    cC=sC(iC);
    ix=find(img_parc==cC); % index of the current cluster
    [~,ix]=ismember(ix,ind_gray); % transform the index
    tmp=img_gray(ix,:); % extract the time series in that cluster
    tmp=mean(tmp,1); % mean time series
    temp(iC,:)=tmp;
end
fea=temp; % mean time series
save(sprintf('feature_1/sub%05d.mat',cSub),'fea');