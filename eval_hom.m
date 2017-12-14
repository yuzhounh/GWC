function eval_hom(method,i)
% functional homogeneity
% 2017-7-25 21:38:44

load stat.mat;
iSub0=stat(i,1);
iK0=stat(i,2);

load sInfo.mat;
cSub0=sSub(iSub0);
cK0=sK(iK0);

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub0,cK0));
load parc_graymatter.mat;
img_parc=img_parc(msk_gray);
sC=unique(img_parc); % the label set of the clusters, should be [1:cK0]
nC=length(sC);

hom=zeros(nSub,1);
for iSub=1:nSub
    cSub=sSub(iSub);
    load(sprintf('data/sub%05d_norm.mat',cSub));

    % within cluster similarity
    a=zeros(nC,1);
    for iC=1:nC
        cC=sC(iC); % current cluster
        ix=find(img_parc==cC);
        nV=length(ix); % number of voxels in this cluster
        if nV~=1
            tmp=img_gray(ix,:)*img_gray(ix,:)';
            tmp=tmp-diag(diag(tmp)); % clear the diagonals
            tmp=sum(tmp(:))/(nV^2-nV); % don't count the diagonals
            a(iC)=tmp;
        end
    end
    a(a==0)=[]; % clear zeros
    hom(iSub,1)=mean(a);
end
hom(iSub0)=[];
hom=mean(hom);
save(sprintf('%s_hom/sub%05d_K%d.mat',method,cSub0,cK0),'hom');
