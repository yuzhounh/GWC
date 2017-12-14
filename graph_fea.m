function G=graph_fea(fea)
% construct a graph from a feature matrix
% 2017-5-18 10:04:29

nC=size(fea,1);   % cluster number
nD=numel(fea)/nC; % feature dimension
F=reshape(fea,[nC,nD]); % reshape features
D=pdist(F);       % distance
D=D/max(D);       % normalized by the maximum value
DS=D.^2;          % square of distance
G=squareform(DS); % graph