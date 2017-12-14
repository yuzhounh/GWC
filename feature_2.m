function feature_2(iSub)
% color histogram
% 2017-3-14 08:25:41

load sInfo.mat;
load parc_graymatter.mat;

cSub=sSub(iSub);
load(sprintf('data/sub%05d.mat',cSub));
load(sprintf('SLIC_supervoxel/sub%05d.mat',cSub));

labels=img_parc(ind_gray); % all labels
sC=unique(labels); 
nC=length(sC); % number of clusters/supervoxels
nBin=12; % number of bins in the histogram
nV=size(img_gray,2); % number of volumes
temp=zeros(nC,nBin,nV);
for iC=1:nC
    cC=sC(iC);
    ix=find(img_parc==cC); % index of the current cluster
    [~,ix]=ismember(ix,ind_gray); % transform the index
    tmp=img_gray(ix,:); % extract the time series in that cluster
    for iV=1:nV
        counts=hist(tmp(:,iV),nBin); 
        temp(iC,:,iV)=counts/sum(counts); % normalize
    end
end
fea=temp; % mean time series
save(sprintf('feature_2/sub%05d.mat',cSub),'fea');