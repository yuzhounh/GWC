function graph_sub(iSub)
% calculate the graphs for each feature and each subject
% 2017-6-4 18:18:59

load sInfo.mat;
cSub=sSub(iSub);

load(sprintf('feature_0/sub%05d.mat',cSub));
G=graph_fea(fea);
graph_spatial=G;

nC=size(fea,1);
graph_features=zeros(nC,nC,3);
for i=1:3
    load(sprintf('feature_%d/sub%05d.mat',i,cSub));
    G=graph_fea(fea);
    graph_features(:,:,i)=G;
end
save(sprintf('graph/sub%05d.mat',cSub),'graph_spatial','graph_features');