function feature_3(iSub)
% LBP historgram 
% 2017-5-15 16:39:55

load sInfo.mat;
load parc_graymatter.mat;

cSub=sSub(iSub);
load(sprintf('feature_LBP/sub%05d.mat',cSub));
load(sprintf('SLIC_supervoxel/sub%05d.mat',cSub));

labels=img_parc(ind_gray); % all labels
sC=unique(labels); 
nC=length(sC); % number of clusters/supervoxels
nBin=10; % number of bins in the histogram, 10 kinds fo LBP features
nV=size(LBP,2); % number of volumes
temp=zeros(nC,nBin,nV);
for iC=1:nC
    cC=sC(iC);
    ix=find(img_parc==cC); % index of the current cluster
    [~,ix]=ismember(ix,ind_gray); % transform the index
    tmp=LBP(ix,:); % extract the LBP features in that cluster
    for iV=1:nV
        counts=hist(tmp(:,iV),nBin); 
        temp(iC,:,iV)=counts/sum(counts); % normalize
    end
end
fea=temp; 
save(sprintf('feature_3/sub%05d.mat',cSub),'fea');
